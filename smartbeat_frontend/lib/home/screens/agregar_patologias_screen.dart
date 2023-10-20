import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartbeat_frontend/home/bloc/cubit/patologias_cubit.dart';
import 'package:smartbeat_frontend/home/bloc/states/patologias_state.dart';
import 'package:smartbeat_frontend/home/models/Patologia.dart';
import 'package:smartbeat_frontend/home/pages/analisis_medico/components/asistente_medico_dialog.dart';
import 'package:smartbeat_frontend/shared/components/custom_scaffold.dart';
import 'package:smartbeat_frontend/shared/components/loading.dart';
import 'package:smartbeat_frontend/shared/utils/app_constants.dart';

class AgregarPatologiasScreen extends StatefulWidget {
  final AgregarPatologiasScreenArgs args;
  static String route = 'agregar_patologias_screen';

  const AgregarPatologiasScreen({super.key, required this.args});

  @override
  _AgregarPatologiasScreenState createState() =>
      _AgregarPatologiasScreenState();
}

class _AgregarPatologiasScreenState extends State<AgregarPatologiasScreen> {
  final TextEditingController _patologiaController = TextEditingController();
  List<Patologia> _patologiasList = [];

  Future<void> updatePatologias() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? formString = prefs.getString(AppConstants.keyPatologias);
    if (formString != null) {
      List<dynamic> patologiasMap = jsonDecode(formString)['patologias'];
      for (var e in patologiasMap) {
        _patologiasList.add(Patologia(pathology: e.toString()));
      }
    }
    setState(() {});
  }

  void _agregarPatologia() {
    setState(() {
      final nuevaPatologia = _patologiaController.text.trim();
      if (nuevaPatologia.isNotEmpty) {
        _patologiasList.add(Patologia(pathology: nuevaPatologia));
        _patologiaController.clear();
      }
    });
  }

  void _eliminarPatologia(int index) {
    setState(() {
      _patologiasList.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    updatePatologias();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => PatologiasCubit(),
        child: BlocConsumer<PatologiasCubit, PatologiasState>(
            listener: (context, state) {
          if (state is PatologiasSuccess) {
            showDialog(
              context: context,
              builder: (context) => AsistenteMedicoDialog(
                newMedicalInformationId: widget.args.medicalInformationId,
                doctorLastName: widget.args.doctorLastName,
                lastMedicalRecordId: widget.args.lastMedicalRecordId,
              ),
            );
          }
        }, builder: (context, state) {
          final cubit = BlocProvider.of<PatologiasCubit>(context);

          return Loading(
            isLoading: state is PatologiasLoading,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Flexible(
                        child: TextField(
                          controller: _patologiaController,
                          decoration:
                              const InputDecoration(labelText: 'Patología'),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      ElevatedButton(
                        onPressed: _agregarPatologia,
                        child: Text('Agregar'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40.0),
                  Text(
                    'Patologías Agregadas:',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 10.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _patologiasList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(_patologiasList[index].pathology),
                              ),
                              IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () => _eliminarPatologia(index),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        cubit.registrarPatologia(
                            widget.args.medicalInformationId, _patologiasList);
                      },
                      child: Text('Continuar'),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class AgregarPatologiasScreenArgs {
  final int medicalInformationId;
  final int lastMedicalRecordId;
  final String doctorLastName;

  const AgregarPatologiasScreenArgs({
    required this.medicalInformationId,
    required this.doctorLastName,
    required this.lastMedicalRecordId,
  });
}
