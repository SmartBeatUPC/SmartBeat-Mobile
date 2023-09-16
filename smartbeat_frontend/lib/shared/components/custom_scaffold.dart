import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';

class CustomScaffold extends StatelessWidget {
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final Color? backgroundColorAppBar;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? body;
  final Widget? title;

  const CustomScaffold({
    Key? key,
    this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.floatingActionButtonLocation,
    this.title,
    this.backgroundColor,
    this.backgroundColorAppBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: title,
          toolbarHeight: title == null ? 0 : null,
          automaticallyImplyLeading: title != null,
          backgroundColor:
              backgroundColorAppBar ?? Theme.of(context).colorScheme.primary,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColors.complementary1.withOpacity(0.85),
          ),
        ),
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        backgroundColor:
            backgroundColor ?? Theme.of(context).colorScheme.primary,
        body: SafeArea(
          child: body ?? const Placeholder(),
        ),
      ),
    );
  }
}
