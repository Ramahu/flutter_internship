import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import '../model/audio_player_state.dart';

class AudioPlayerNotifier extends StateNotifier<AsyncValue<AudioState>> {
  AudioPlayerNotifier() : super(const AsyncValue.loading()) {
    _init();
  }

  late final AudioPlayer _audioPlayer;
  final List<double> speedOptions = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];

  void _init() {
    _audioPlayer = AudioPlayer();

    _audioPlayer.playerStateStream.listen((playerState) {
      state = state.whenData((current) => current.copyWith(
            isPlaying: playerState.playing,
            isBuffering:
                playerState.processingState == ProcessingState.buffering,
          ));
    });

    _audioPlayer.positionStream.listen((pos) {
      state = state.whenData((current) => current.copyWith(position: pos));
    });
  }

  Future<void> setAudioSource(String url) async {
    try {
      final currentState = state.value ?? AudioState.initial();
      state =
          AsyncValue.data(currentState.copyWith(isLoading: true, error: null));

      await _audioPlayer.setUrl(url);

      _audioPlayer.durationStream.listen((duration) {
        if (duration != null) {
          state =
              state.whenData((current) => current.copyWith(total: duration));
        }
      });

      state = AsyncValue.data(currentState.copyWith(
        isLoading: false,
        total: _audioPlayer.duration ?? Duration.zero,
      ));
    } catch (e, st) {
      // ignore: avoid_print
      print('Audio load error: $e');
      state = AsyncValue.error(e.toString(), st);
    }
  }

  void play() => _audioPlayer.play();

  void pause() => _audioPlayer.pause();

  void seek(Duration pos) => _audioPlayer.seek(pos);

  void setSpeed(double speed) {
    _audioPlayer.setSpeed(speed);
    state = state.whenData((s) => s.copyWith(speed: speed));
  }

  void setVolume(double volume) {
    _audioPlayer.setVolume(volume);
    state = state.whenData((s) => s.copyWith(volume: volume));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}

final audioPlayerProvider =
    StateNotifierProvider<AudioPlayerNotifier, AsyncValue<AudioState>>(
  (ref) => AudioPlayerNotifier(),
);
