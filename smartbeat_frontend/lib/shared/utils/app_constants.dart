import 'package:smartbeat_frontend/shared/components/custom_dialog.dart';

class AppConstants {
  static Map<DialogHeightSize, double> mapDialogSize = Map.of({
    DialogHeightSize.extraSmall: 225.0,
    DialogHeightSize.small: 300.0,
    DialogHeightSize.medium: 500.0,
    DialogHeightSize.large: 850.0
  });
  static const String keyInfoApp = 'infoApp';
}
