import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/shared/utils/app_images.dart';

enum LoadingType { primary, transparent }

class Loading extends StatefulWidget {
  final bool isLoading;
  final Widget child;
  final LoadingType type;

  const Loading({
    Key? key,
    this.isLoading = false,
    required this.child,
    this.type = LoadingType.transparent,
  }) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  final double _opacity = 0.5;
  final double _sizeIndicator = 50.0;
  final double _radioCircularProgress = 75.0;
  final double _strokeWidthIndicator = 6.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (widget.isLoading)
          Container(
            color: widget.type == LoadingType.transparent
                ? Theme.of(context).colorScheme.background.withOpacity(_opacity)
                : Theme.of(context).primaryColor,
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    AppImages.splashIcon,
                    height: _sizeIndicator,
                    width: _sizeIndicator,
                  ),
                  SizedBox(
                    height: _radioCircularProgress,
                    width: _radioCircularProgress,
                    child: CircularProgressIndicator(
                      color: widget.type == LoadingType.transparent
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.secondary,
                      strokeWidth: _strokeWidthIndicator,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
