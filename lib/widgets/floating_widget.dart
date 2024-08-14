import 'package:animated_floating_widget/animated_floating_widget.dart';
import 'package:flutter/material.dart';

import '../enums/directions.dart';

class FloatingWidget extends StatefulWidget {
  /// The widget you want to be displayed with the floating effect.
  final Widget child;

  /// Duration for the start animation direction.
  final Duration? duration;

  /// Duration for the reversed animation (when the animation returns to the first step).
  final Duration? reverseDuration;

  /// Directions for the floating type you want to show the widget with.
  final FloatingDirection? direction;

  /// Horizontal space that the widget will move and return to.
  final double? horizontalSpace;

  /// Vertical space that the widget will move and return to.
  final double? verticalSpace;

  /// If you want to pass a specific offset to start the animation from, according to your use.
  final Offset? beginOffset;

  /// If you want to pass a specific offset to end the animation, according to your use.
  final Offset? endOffset;

  const FloatingWidget(
      {Key? key,
      required this.child,
      this.duration,
      this.reverseDuration,
      this.direction = FloatingDirection.topCenterToBottomCenter,
      this.horizontalSpace = 30,
      this.verticalSpace = 30,
      this.beginOffset,
      this.endOffset})
      : super(key: key);

  @override
  State<FloatingWidget> createState() => _FloatingWidgetState();
}

class _FloatingWidgetState extends State<FloatingWidget>
    with TickerProviderStateMixin {
  /// Animation controller to manage the floating animation.
  late AnimationController controller;

  /// Offset values for the beginning and end of the animation.
  late Offset beginOffset;
  late Offset endOffset;

  @override
  void initState() {
    super.initState();

    /// Initialize the animation controller with the provided duration and reverse duration.
    /// The `vsync` parameter is required to sync the animation with the widget's lifecycle.
    controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? const Duration(seconds: 2),
      reverseDuration: widget.reverseDuration ?? const Duration(seconds: 2),
    )..addStatusListener((AnimationStatus status) {
        /// Reverse the animation when it reaches the end, and forward it when it returns to the start.
        if (status == AnimationStatus.completed) controller.reverse();
        if (status == AnimationStatus.dismissed) controller.forward();
      });

    /// Start the animation.
    controller.forward();

    /// Calculate the offset values based on the provided direction or custom offsets.
    calculateOffset(widget.direction!);
  }

  /// Method to calculate the beginning and end offsets for the animation.
  void calculateOffset(
    FloatingDirection direction,
  ) {
    /// If custom offsets are provided, use them directly.
    if (widget.beginOffset != null && widget.endOffset != null) {
      beginOffset = widget.beginOffset!;
      endOffset = widget.endOffset!;
    } else {
      /// Calculate the offsets based on the selected floating direction.
      if (direction == FloatingDirection.topCenterToBottomCenter) {
        beginOffset = Offset(0, -(widget.verticalSpace! / 100));
        endOffset = Offset(0, (widget.verticalSpace! / 100));
      } else if (direction == FloatingDirection.leftCenterToRightCenter) {
        beginOffset = Offset(
          -(widget.horizontalSpace! / 100),
          0,
        );
        endOffset = Offset(
          (widget.horizontalSpace! / 100),
          0,
        );
      } else if (direction == FloatingDirection.topLeftToBottomRight) {
        beginOffset = Offset(
          -(widget.horizontalSpace! / 100),
          -(widget.verticalSpace! / 100),
        );
        endOffset = Offset(
          (widget.horizontalSpace! / 100),
          (widget.verticalSpace! / 100),
        );
      } else if (direction == FloatingDirection.topRightToBottomLeft) {
        beginOffset = Offset(
          (widget.horizontalSpace! / 100),
          -(widget.verticalSpace! / 100),
        );
        endOffset = Offset(
          -(widget.horizontalSpace! / 100),
          (widget.verticalSpace! / 100),
        );
      }
    }
  }

  @override
  void dispose() {
    /// Properly dispose of the AnimationController to free up resources.
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(

        /// Create a SlideTransition widget that animates the position of the child widget
        /// between the beginning and end offsets.
        position: Tween<Offset>(begin: beginOffset, end: endOffset)
            .animate(controller),
        child: widget.child);
  }
}
