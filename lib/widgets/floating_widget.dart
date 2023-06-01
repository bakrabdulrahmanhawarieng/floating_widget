import 'package:flutter/material.dart';
import '../enums/directions.dart';

class FloatingWidget extends StatefulWidget {
  /// widget you want to be displayed
  final Widget child;
  /// duration for the start animation direction
  final Duration? duration;
  /// duration for reversed animation (when the animation back to first step)
  final Duration? reverseDuration;
  /// directions for floating type you want to show the widget with
  final FloatingDirection? direction;
  /// horizontal space that widget will move and back to
  final double? horizontalSpace;
  /// Vertical space that widget will move and back to
  final double? verticalSpace;
  /// if you want to pass specific offset to animation start from, according to your use
  final Offset? beginOffset;
  /// if you want to pass specific offset to animation end according to your use
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
  late AnimationController controller;
  late Offset beginOffset;
  late Offset endOffset;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? const Duration(seconds: 2),
      reverseDuration: widget.reverseDuration ?? const Duration(seconds: 2),
    )..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) controller.reverse();
        if (status == AnimationStatus.dismissed) controller.forward();
      });

    controller.forward();
    calculateOffset(widget.direction!);
  }

  void calculateOffset(
    FloatingDirection direction,
  ) {
    if (widget.beginOffset != null && widget.endOffset != null) {
      beginOffset = widget.beginOffset!;
      endOffset = widget.endOffset!;
    } else {
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
  Widget build(BuildContext context) {
    return SlideTransition(
        position: Tween<Offset>(begin: beginOffset, end: endOffset)
            .animate(controller),
        child: widget.child);
  }
}
