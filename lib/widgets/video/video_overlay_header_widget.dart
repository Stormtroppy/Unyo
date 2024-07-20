import 'package:desktop_keep_screen_on/desktop_keep_screen_on.dart';
import 'package:flutter/material.dart';
import 'package:unyo/screens/video_screen.dart';
import 'package:unyo/util/mixed_controller.dart';

class VideoOverlayHeaderWidget extends StatefulWidget {
  const VideoOverlayHeaderWidget(
      {super.key,
      required this.showControls,
      required this.title,
      required this.mixedController,
      required this.updateEntry
      });

  final bool showControls;
  final String title;
  final MixedController mixedController;
  final void Function() updateEntry;

  @override
  State<VideoOverlayHeaderWidget> createState() =>
      _VideoOverlayHeaderWidgetState();
}

class _VideoOverlayHeaderWidgetState extends State<VideoOverlayHeaderWidget> {
  late bool showControls;

  @override
  void initState() {
    super.initState();
    showControls = widget.showControls;
  }

  @override
  void didUpdateWidget(covariant VideoOverlayHeaderWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.showControls != widget.showControls){
      showControls = widget.showControls;
    }
  }

  void interactScreen(bool keepOn) async {
    await DesktopKeepScreenOn.setPreventSleep(keepOn);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedOpacity(
          opacity: showControls ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: FocusScope(
            canRequestFocus: false,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                if (!fullScreen) {
                  // sendEscapeOrder();
                  widget.mixedController.dispose();

                  interactScreen(false);
                  if (widget.mixedController.mqqtController
                          .calculatePercentage() >
                      0.8) {
                    widget.updateEntry();
                  }
                  Navigator.pop(context);
                }
              },
              color: Colors.white,
            ),
          ),
        ),
        AnimatedOpacity(
          opacity: showControls ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: Padding(
            padding: const EdgeInsets.only(left: 6.0, top: 2.0),
            child: Text(widget.title,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 15)),
          ),
        )
      ],
    );
  }
}
