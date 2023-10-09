import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/home/pages/chatbot/chatbot_screen.dart';
import 'package:smartbeat_frontend/shared/components/custom_dialog.dart';

class AsistenteMedicoDialog extends StatelessWidget {
  final int newMedicalInformationId;

  const AsistenteMedicoDialog({
    super.key,
    required this.newMedicalInformationId,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      hasClose: false,
      size: DialogHeightSize.extraSmall,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Continuar con: ',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    ChatBotScreen.route,
                    arguments: ChatBotScreenArgs(
                        medicalInformationId: newMedicalInformationId),
                  );
                },
                child: Text('Asistente'),
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                child: Text('Diagnostico'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
