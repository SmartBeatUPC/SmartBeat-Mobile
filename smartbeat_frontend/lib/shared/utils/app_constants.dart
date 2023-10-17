import 'package:smartbeat_frontend/shared/components/custom_dialog.dart';

class AppConstants {
  static Map<DialogHeightSize, double> mapDialogSize = Map.of({
    DialogHeightSize.extraSmall: 225.0,
    DialogHeightSize.small: 450.0,
    DialogHeightSize.medium: 580.0,
    DialogHeightSize.large: 850.0
  });
  static const String keyInfoApp = 'infoApp';
  static const String keyRememberedForm = 'rememberedLoginValues';
  static const String codigoPaisPeru = '+51';
}
