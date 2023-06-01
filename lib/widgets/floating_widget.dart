import 'package:flutter/material.dart';
import '../enums/directions.dart';

class FloatingWidget extends StatefulWidget {
  final Widget child;
  final Duration? duration;
  final Duration? reverseDuration;
  final FloatingDirection? direction;
  final double? horizontalSpace;
  final double? verticalSpace;
  final Offset? beginOffset;
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
