import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/shared/utils/app_constants.dart';

enum DialogHeightSize { extraSmall, small, medium, large, fullscreen }

class CustomDialog extends StatelessWidget {
  final Widget body;
  final VoidCallback? onClickButton;
  final String? textButton;
  final DialogHeightSize size;
  final bool hasClose;

  const CustomDialog({
    Key? key,
    required this.body,
    this.hasClose = true,
    this.onClickButton,
    this.textButton,
    this.size = DialogHeightSize.medium,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (size == DialogHeightSize.fullscreen) {
      return Dialog.fullscreen(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (hasClose)
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            Expanded(child: body),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20.0,
                left: 20.0,
                right: 20.0,
              ),
              child: ElevatedButton(
                onPressed: onClickButton!,
                child: Text(
                  textButton != null ? textButton! : '',
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      surfaceTintColor: Colors.white,
      child: SizedBox(
        height: AppConstants.mapDialogSize[size],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (hasClose)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            Expanded(
              child: body,
            ),
            if (onClickButton != null)
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 20.0, left: 20.0, right: 20.0),
                child: ElevatedButton(
                  onPressed: onClickButton!,
                  child: Text(
                    textButton != null ? textButton! : '',
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
