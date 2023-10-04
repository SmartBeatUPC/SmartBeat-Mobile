import 'package:bloc/bloc.dart';
import 'package:smartbeat_frontend/seguridad/bloc/state/info_app_state.dart';
import 'package:smartbeat_frontend/seguridad/models/session_info.dart';

class InfoAppCubit extends Cubit<InfoAppState> {
  late SessionInfo _sessionInfo;

  InfoAppCubit() : super(InfoAppInitial()) {}

  void setInfoApp(SessionInfo sessionInfo) {
    _sessionInfo = sessionInfo;
  }

  SessionInfo get infoApp => _sessionInfo;
}
