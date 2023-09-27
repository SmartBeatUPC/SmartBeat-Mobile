import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/home/components/custom_info_card.dart';
import 'package:smartbeat_frontend/home/pages/profile/components/header_section.dart';
import 'package:smartbeat_frontend/home/pages/profile/components/medico_detail_section.dart';
import 'package:smartbeat_frontend/home/pages/profile/components/paciente_detail_section.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/screens/datos_personales_screen.dart';
import 'package:smartbeat_frontend/shared/components/custom_scaffold.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';
import 'package:smartbeat_frontend/shared/utils/app_images.dart';

class ProfilePage extends StatelessWidget {
  final TypeUser typeUser;

  const ProfilePage({super.key, required this.typeUser});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: Colors.white,
      useAppBar: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 30.0),
            HeaderSection(
                pathImg: typeUser == TypeUser.patient
                    ? AppImages.paciente2
                    : AppImages.medico,
                title: typeUser == TypeUser.patient
                    ? 'Juan López' : 'Dra. Jésica Girón'),
            if(typeUser == TypeUser.patient)
              PacienteDetailSection(),
            if(typeUser == TypeUser.doctor)
              MedicoDetailSection(),
          ],
        ),
      ),
    );
  }
}
