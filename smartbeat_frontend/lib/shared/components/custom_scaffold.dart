import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/seguridad/bloc/cubit/info_app_cubit.dart';
import 'package:smartbeat_frontend/seguridad/screens/login/screens/login_screen.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/screens/datos_personales_screen.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';
import 'package:smartbeat_frontend/shared/utils/app_images.dart';
import 'package:smartbeat_frontend/shared/utils/utils.dart';

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
    final infoAppCubit = BlocProvider.of<InfoAppCubit>(context);
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: useAppBar
            ? AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.splashIcon,
                      height: 40.0,
                    ),
                    const SizedBox(width: 5.0),
                    Image.asset(
                      backgroundColor != null
                          ? AppImages.splashText
                          : AppImages.splashTextWhite,
                      height: 20.0,
                    ),
                  ],
                ),
                leading: Builder(
                  builder: (context) => Container(
                    padding: const EdgeInsets.all(7.5),
                    child: IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_sharp),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
                backgroundColor:
                    backgroundColor ?? Theme.of(context).colorScheme.primary,
                centerTitle: true,
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                ),
              )
            : null,
        drawer: useAppBar
            ? Drawer(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Column(
                  children: [
                    Container(
                      height: 190,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: AppColors.secondary,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 20.0,
                                    left: 10.0,
                                    right: 10.0,
                                  ),
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.grey[100],
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: AssetImage(
                                        Utils.getImageProfile(
                                            infoAppCubit
                                                .infoApp.dataUser!.gender!,
                                            infoAppCubit.infoApp.typeUser!),
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    const SizedBox(height: 5.0),
                                    Text(
                                      "${infoAppCubit.infoApp.dataUser!.name!} ${infoAppCubit.infoApp.dataUser!.lastName!}",
                                      style: textTheme.titleLarge?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${infoAppCubit.infoApp.dataUser!.age!} años",
                                      style: textTheme.titleSmall?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Actualizar mis datos",
                      ),
                      leading: Icon(Icons.line_weight_rounded,
                          size: 25.0, color: Colors.grey),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, LoginScreen.route, (_) => false);
                        infoAppCubit.signOut();
                      },
                      child: ListTile(
                        title: Text(
                          "Cerrar sesion",
                        ),
                        leading: Icon(Icons.logout_outlined,
                            size: 25.0, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              )
            : null,
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
