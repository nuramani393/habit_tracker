import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:habit_tracker/src/constants/colors.dart';
import 'package:habit_tracker/src/features/core/screens/explore/video_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoDetailsPage extends StatefulWidget {
  // final Video video;
  // final String videoId;
  final Map<String, String> videoData;

  // const VideoDetailsPage({Key? key, required this.video}) : super(key: key);
  const VideoDetailsPage({Key? key, required this.videoData}) : super(key: key);

  @override
  _VideoDetailsPageState createState() => _VideoDetailsPageState();
}

class _VideoDetailsPageState extends State<VideoDetailsPage> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      // initialVideoId: widget.video.id,
      initialVideoId: widget.videoData['videoId']!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        enableCaption: true,
      ),
    );

    _controller.addListener(listener);
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {});
    }
    if (_controller.value.isFullScreen) {
      // Set landscape mode when entering fullscreen
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      // Set portrait mode when exiting fullscreen
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.removeListener(listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: midColor,
        progressColors: const ProgressBarColors(
          playedColor: darkColor,
          handleColor: darkColor,
        ),
        onReady: () {
          setState(() {
            _isPlayerReady = true;
          });
          debugPrint('Player is ready.');
        },
        bottomActions: [
          CurrentPosition(),
          ProgressBar(
            isExpanded: true,
            colors: const ProgressBarColors(
              playedColor: darkColor,
              handleColor: darkColor,
            ),
          ),
          const PlaybackSpeedButton(),
          RemainingDuration(),
          FullScreenButton(),
        ],
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: bgColor,
            title: const Text('YouTube Player'),
            centerTitle: true,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    constraints: _controller.value.isFullScreen
                        ? BoxConstraints
                            .expand() // Allow video to expand to full screen
                        : BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * 0.6,
                          ), // Set max
                    child: AspectRatio(aspectRatio: 16 / 9, child: player),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    // widget.video.title,
                    widget.videoData['title']!
                        .split(' ')
                        .map(
                            (word) => word[0].toUpperCase() + word.substring(1))
                        .join(' '),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: darkColor,
                        ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    // 'By ${widget.video.creator}',
                    'By ${widget.videoData['author']}',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: darkColor,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
