import 'dart:math';

import 'package:flutter/material.dart';

enum DetectorSide {
  left,
  right,
}

/// A view which splits the screen into three parts with adjustable width
/// controls
class TrippleSplitView extends StatefulWidget {
  const TrippleSplitView({
    Key? key,
    this.leftMinWidth = 300,
    this.rightMinWidth = 400,
    required this.leftChild,
    required this.centerChild,
    required this.rightChild,
  }) : super(key: key);

  final double leftMinWidth;
  final double rightMinWidth;
  final Widget leftChild;
  final Widget centerChild;
  final Widget rightChild;

  @override
  State<TrippleSplitView> createState() => _TrippleSplitViewState();
}

class _TrippleSplitViewState extends State<TrippleSplitView> {
  final dividerWidth = 16.0;
  bool isInitialized = false;
  late double currentTotalWidth;
  late double totalHeight;
  bool showLeft = true;
  late double leftRatio;
  bool showRight = true;
  late double rightRatio;

  @override
  void initState() {
    super.initState();
  }

  Widget buildGestureDetector(
    DetectorSide detectorSide,
  ) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: SizedBox(
        width: dividerWidth,
        height: totalHeight,
        child: RotationTransition(
          turns: const AlwaysStoppedAnimation(0.25),
          child: Icon(
            Icons.drag_handle,
            color: Theme.of(context).cardColor,
          ),
        ),
      ),
      onTap: () {
        setState(() {
          if (detectorSide == DetectorSide.left) {
            final minRatio = widget.leftMinWidth / currentTotalWidth;

            if (leftRatio < minRatio) {
              leftRatio = minRatio;
              showLeft = true;
            }
          } else {
            final minRatio = widget.rightMinWidth / currentTotalWidth;

            if (rightRatio < minRatio) {
              rightRatio = minRatio;
              showRight = true;
            }
          }
        });
      },
      onPanUpdate: (DragUpdateDetails details) {
        setState(() {
          final deltaRatio = details.delta.dx / currentTotalWidth;

          if (detectorSide == DetectorSide.left) {
            final minRatio = widget.leftMinWidth / currentTotalWidth;
            var newRatio = leftRatio + deltaRatio;
            if (!showLeft && deltaRatio > 0) {
              newRatio = minRatio;
              showLeft = true;
            } else if (newRatio < minRatio) {
              showLeft = false;
              newRatio = 0;
            } else {
              showLeft = true;
            }
            leftRatio = max(0, newRatio);
          } else {
            final minRatio = widget.rightMinWidth / currentTotalWidth;
            var newRatio = rightRatio - deltaRatio;
            if (!showRight && deltaRatio < 0) {
              newRatio = minRatio;
              showRight = true;
            } else if (newRatio < minRatio) {
              showRight = false;
              newRatio = 0;
            } else {
              showRight = true;
            }
            rightRatio = max(0, newRatio);
          }
        });
      },
    );
  }

  void initializeRatios(
    double newWidth,
  ) {
    leftRatio = widget.leftMinWidth / newWidth;
    rightRatio = widget.rightMinWidth / newWidth;

    isInitialized = true;
  }

  void recalculateRatios(double newSize) {
    final leftSize = currentTotalWidth * leftRatio;
    final rightSize = currentTotalWidth * rightRatio;

    leftRatio = leftSize / newSize;
    rightRatio = rightSize / newSize;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, BoxConstraints constraints) {
        final newMaxWidth = constraints.maxWidth - dividerWidth * 2;
        if (isInitialized && newMaxWidth != totalHeight) {
          recalculateRatios(newMaxWidth);
        }
        totalHeight = constraints.maxHeight;
        currentTotalWidth = newMaxWidth;
        if (!isInitialized) {
          initializeRatios(currentTotalWidth);
        }

        return Row(
          children: [
            SizedBox(
              width: leftRatio * currentTotalWidth,
              child: showLeft ? widget.leftChild : Container(),
            ),
            buildGestureDetector(DetectorSide.left),
            Expanded(child: widget.centerChild),
            buildGestureDetector(DetectorSide.right),
            SizedBox(
              width: rightRatio * currentTotalWidth,
              child: showRight ? widget.rightChild : Container(),
            ),
          ],
        );
      },
    );
  }
}
