import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/home/bloc/cubit/patologias_cubit.dart';
import 'package:smartbeat_frontend/home/bloc/states/patologias_state.dart';
import 'package:smartbeat_frontend/home/models/Patologia.dart';
import 'package:smartbeat_frontend/home/pages/analisis_medico/components/asistente_medico_dialog.dart';
import 'package:smartbeat_frontend/shared/components/custom_scaffold.dart';
import 'package:smartbeat_frontend/shared/components/loading.dart';

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
  final List<Patologia> _patologiasList = [];

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

  const AgregarPatologiasScreenArgs({required this.medicalInformationId});
}
