import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/home/screens/home_nav_bar_screen.dart';
import 'package:smartbeat_frontend/seguridad/bloc/cubit/info_app_cubit.dart';
import 'package:smartbeat_frontend/seguridad/bloc/cubit/login_cubit.dart';
import 'package:smartbeat_frontend/seguridad/bloc/state/login_state.dart';
import 'package:smartbeat_frontend/seguridad/screens/login/components/form_section.dart';
import 'package:smartbeat_frontend/seguridad/screens/login/components/footer_section.dart';
import 'package:smartbeat_frontend/shared/components/custom_scaffold.dart';
import 'package:smartbeat_frontend/shared/components/loading.dart';
import 'package:smartbeat_frontend/shared/utils/utils.dart';

class LoginScreen extends StatelessWidget {
  static String route = 'login_screen';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubitInfoApp = BlocProvider.of<InfoAppCubit>(context);

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            Utils.showSnackBar(context, 'Credenciales incorrectas.');
          }

          if (state is LoginSuccess) {
            cubitInfoApp.setInfoApp(state.infoSession);

            Navigator.pushNamedAndRemoveUntil(
                context, HomeNavBarScreen.route, (_) => false,
                arguments: const HomeNavBarScreenArgs(indexPage: 1));
          }
        },
        builder: (context, state) {
          return Loading(
            isLoading: state is LoginLoading,
            child: CustomScaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        '!Bienvenido¡ Un placer\ntenerte de vuelta',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: FormSection(),
                    ),
                    const SizedBox(height: 35.0),
                    const FooterSection(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
