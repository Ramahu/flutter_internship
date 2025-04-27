import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/util/colors.dart';
import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../lessons/widget/state_widget.dart';
import '../provider/audio_player_notifier.dart';

class AudioPlayerScreen extends ConsumerStatefulWidget {
  const AudioPlayerScreen({required this.url, super.key});
  final String url;

  @override
  ConsumerState<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends ConsumerState<AudioPlayerScreen> {
  bool _isLoading = true;
  String? _redirectedUrl;

  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            debugPrint('Redirected URL: ${request.url}');
            if (_redirectedUrl == null) {
              _redirectedUrl = request.url;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  ref
                      .read(audioPlayerProvider.notifier)
                      .setAudioSource(_redirectedUrl!);
                  setState(() => _isLoading = false);
                }
              });

              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          // widget.url
          'https://file-examples.com/wp-content/storage/2017/11/file_example_MP3_700KB.mp3'));
  }

  @override
  void dispose() {
    _webViewController.clearCache();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final playerState = ref.watch(audioPlayerProvider);
    final playerNotifier = ref.read(audioPlayerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).audioPlayer),
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? loadingWidget()
            : playerState.when(
                loading: loadingWidget,
                error: (e, _) => errorWidget(e),
                data: (state) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      height: 190,
                      image: AssetImage(Assets.assetsLogo),
                    ),
                    const SizedBox(height: 35),
                    Row(
                      children: [
                        IconButton(
                          iconSize: 36,
                          icon: Icon(
                            state.isPlaying ? Icons.pause : Icons.play_arrow,
                          ),
                          onPressed: () {
                            state.isPlaying
                                ? playerNotifier.pause()
                                : playerNotifier.play();
                          },
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Slider(
                            value: state.position.inSeconds
                                .clamp(0, state.total.inSeconds)
                                .toDouble(),
                            max: state.total.inSeconds
                                .toDouble()
                                .clamp(1, double.infinity),
                            onChanged: (value) {
                              playerNotifier
                                  .seek(Duration(seconds: value.toInt()));
                            },
                            activeColor: defaultBlue2,
                            thumbColor: defaultBlue2,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Text(formatDuration(state.position),
                              style: const TextStyle(fontSize: 18)),
                          const Spacer(),
                          Text(formatDuration(state.total),
                              style: const TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppLocalizations.of(context).speed),
                          const SizedBox(width: 10),
                          DropdownButton<double>(
                            value: state.speed,
                            items: playerNotifier.speedOptions.map((speed) {
                              return DropdownMenuItem(
                                value: speed,
                                child: Text('${speed}x'),
                              );
                            }).toList(),
                            onChanged: state.isLoading
                                ? null
                                : (speed) {
                                    if (speed != null) {
                                      playerNotifier.setSpeed(speed);
                                    }
                                  },
                          ),
                          const Spacer(),
                          PopupMenuButton(
                            tooltip: AppLocalizations.of(context).Volume,
                            itemBuilder: (_) => [
                              PopupMenuItem(
                                padding: EdgeInsets.zero,
                                child: Consumer(
                                  builder: (context, ref, _) {
                                    final state =
                                        ref.watch(audioPlayerProvider).value!;
                                    final notifier =
                                        ref.read(audioPlayerProvider.notifier);
                                    return SizedBox(
                                      child: RotatedBox(
                                        quarterTurns: -1,
                                        child: Slider(
                                          activeColor: defaultBlue2,
                                          thumbColor: defaultBlue2,
                                          value: state.volume,
                                          min: 0.0,
                                          max: 1.0,
                                          divisions: 10,
                                          label: (state.volume * 100)
                                              .toStringAsFixed(0),
                                          onChanged: notifier.setVolume,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                            child: const Icon(Icons.volume_up),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
