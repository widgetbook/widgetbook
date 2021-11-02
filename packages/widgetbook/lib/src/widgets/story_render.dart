import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:widgetbook/src/models/organizers/organizers.dart';
import 'package:widgetbook/src/providers/canvas_provider.dart';
import 'package:widgetbook/src/providers/zoom_provider.dart';
import 'package:widgetbook/src/widgets/device_render.dart';

class StoryRender extends StatefulWidget {
  const StoryRender({Key? key}) : super(key: key);

  @override
  _StoryState createState() => _StoryState();
}

class _StoryState extends State<StoryRender> {
  TransformationController controller = TransformationController(
    Matrix4.identity(),
  );

  Widget _buildStory() {
    final state = CanvasProvider.of(context)!.state;
    if (state.selectedStory != null) {
      return _buildCanvas(state.selectedStory!);
    }

    return Center(
      child: Container(),
    );
  }

  void _updateController() {
    final state = ZoomProvider.of(context)!.state;

    final oldMatrix = controller.value;

    final translation = oldMatrix.getTranslation();

    final rotation = oldMatrix.getRotation();
    oldMatrix.setFromTranslationRotationScale(
      translation,
      vector.Quaternion.fromRotation(rotation),
      vector.Vector3.all(state.zoomLevel),
    );
    controller = TransformationController(oldMatrix);
  }

  Widget _buildCanvas(WidgetbookUseCase story) {
    _updateController();

    return InteractiveViewer(
      boundaryMargin: const EdgeInsets.all(double.infinity),
      minScale: 0.25,
      maxScale: 5,
      constrained: false,
      transformationController: controller,
      onInteractionUpdate: (ScaleUpdateDetails details) {
        ZoomProvider.of(context)!
            .setScale(controller.value.getMaxScaleOnAxis());
      },
      child: DeviceRender(
        story: story,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildStory();
  }
}
