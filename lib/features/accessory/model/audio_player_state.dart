class AudioState {
  factory AudioState.initial() => AudioState(
        position: Duration.zero,
        total: Duration.zero,
        isPlaying: false,
        isLoading: false,
        isBuffering: false,
        speed: 1.0,
        volume: 1.0,
        error: null,
      );
  AudioState({
    required this.position,
    required this.total,
    required this.isPlaying,
    required this.isLoading,
    required this.isBuffering,
    required this.speed,
    required this.volume,
    this.error,
  });
  final Duration position;
  final Duration total;
  final bool isPlaying;
  final bool isLoading;
  final bool isBuffering;
  final double speed;
  final double volume;
  final String? error;

  AudioState copyWith({
    Duration? position,
    Duration? total,
    bool? isPlaying,
    bool? isLoading,
    bool? isBuffering,
    double? speed,
    double? volume,
    String? error,
  }) {
    return AudioState(
      position: position ?? this.position,
      total: total ?? this.total,
      isPlaying: isPlaying ?? this.isPlaying,
      isLoading: isLoading ?? this.isLoading,
      isBuffering: isBuffering ?? this.isBuffering,
      speed: speed ?? this.speed,
      volume: volume ?? this.volume,
      error: error ?? this.error,
    );
  }
}
