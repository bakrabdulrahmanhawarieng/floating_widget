

**Version 1.0.0**

- **Enhancement**: Added proper disposal of `AnimationController` in `FloatingWidget` to prevent memory leaks. The `dispose` method now ensures that the controller is correctly disposed of when the widget is removed from the widget tree.

**Version 0.0.6** (Initial Release)

- **Feature**: Introduced the `FloatingWidget` with customizable floating animation directions:
  - `topCenterToBottomCenter`
  - `leftCenterToRightCenter`
  - `topLeftToBottomRight`
  - `topRightToBottomLeft`
- **Feature**: Configurable animation duration (`duration`) and reverse animation duration (`reverseDuration`).
- **Feature**: Added support for custom horizontal (`horizontalSpace`) and vertical (`verticalSpace`) movement.
- **Feature**: Provided options to define specific start (`beginOffset`) and end (`endOffset`) offsets for the animation.

