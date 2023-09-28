import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/shared/components/custom_gradient_background.dart';
import 'package:smartbeat_frontend/shared/components/custom_scaffold.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';
import 'package:smartbeat_frontend/shared/utils/app_images.dart';

class ConexionQrPage extends StatelessWidget {
  const ConexionQrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      useAppBar: true,
      backgroundColorAppBar: Colors.white,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomGradientBackground(
            colors: [
              AppColors.primary.withOpacity(0.01),
              AppColors.primary.withOpacity(0.30),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                Text(
                  'Tu camino a un\ncorazón saludable',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Presenta tu QR al médico para un registro preciso de tu perfil cardiovascular. Este código facilita una conexión directa, permitiendo un seguimiento detallado de tu salud y un cuidado personalizado. Tu viaje hacia un corazón saludable comienza con un simple escaneo.',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: AppColors.secondary, letterSpacing: 1.0),
                ),
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Image.asset(
                    AppImages.qrConexion,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}