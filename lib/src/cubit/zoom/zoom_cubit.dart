import 'package:bloc/bloc.dart';

part 'zoom_state.dart';

class ZoomCubit extends Cubit<ZoomState> {
  final double levelChange = 0.25;

  ZoomCubit()
      : super(
          ZoomState.normal(),
        );

  void zoomIn() {
    emit(
      ZoomState(
        zoomLevel: state.zoomLevel + levelChange,
      ),
    );
  }

  void setScale(double scale) {
    emit(
      ZoomState(
        zoomLevel: scale,
      ),
    );
  }

  void zoomOut() {
    emit(
      ZoomState(
        zoomLevel: (state.zoomLevel - levelChange).clamp(
          0.25,
          999,
        ),
      ),
    );
  }

  void resetToNormal() {
    emit(
      ZoomState.normal(),
    );
  }
}
