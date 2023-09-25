import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';
import 'package:smartbeat_frontend/shared/utils/app_images.dart';

class CustomScaffold extends StatelessWidget {
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final Color? backgroundColorAppBar;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? body;
  final bool useAppBar;

  const CustomScaffold({
    Key? key,
    this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.floatingActionButtonLocation,
    this.backgroundColor,
    this.backgroundColorAppBar,
    this.useAppBar = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: useAppBar ? AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.splashIcon,
                height: 40.0,
              ),
              const SizedBox(width: 5.0),
              Image.asset(
                backgroundColor != null ? AppImages.splashText: AppImages.splashTextWhite,
                height: 20.0,
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_sharp),
              onPressed: () {},
            ),
          ],
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
          backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
          centerTitle: true,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
          ),
        ) : null,
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
