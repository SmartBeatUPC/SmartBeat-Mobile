import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:smartbeat_frontend/home/models/medida_presion_paciente.dart';
import 'package:smartbeat_frontend/home/pages/analisis_medico/analisis_medico_screen.dart';
import 'package:smartbeat_frontend/shared/models/slide.dart';

class BodyIndicationMedicion extends StatefulWidget {
  final TypeMedicion typeSelected;
  final Function(MedidaPresionPaciente?) onChangeMedidaPresion;

  const BodyIndicationMedicion({
    super.key,
    required this.typeSelected,
    required this.onChangeMedidaPresion,
  });

  @override
  State<BodyIndicationMedicion> createState() => _BodyIndicationMedicionState();
}

class _BodyIndicationMedicionState extends State<BodyIndicationMedicion> {
  MedidaPresionPaciente? medidaPresionPaciente;
  List<Widget> sliders = [];
  var slides = List.generate(
    6,
    (index) => Slide(
      title: 'Slide ${index + 1}',
      height: 100.0 + index * 50,
      color: Colors.primaries[index % Colors.primaries.length],
    ),
  );

  @override
  void initState() {
    super.initState();
    sliders = slides
        .map(
          (item) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              child: Container(
                color: item.color,
                width: double.infinity,
                height: item.height,
                child: Center(
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(height: 20.0),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 20.0),
            child: FlutterCarousel(
              options: CarouselOptions(
                autoPlay: false,
                disableCenter: true,
                viewportFraction: deviceSize.width > 800.0 ? 0.8 : 1.0,
                indicatorMargin: 10.0,
                enableInfiniteScroll: true,
                slideIndicator: const CircularSlideIndicator(),
              ),
              items: sliders,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: OutlinedButton(
            onPressed: () {
              medidaPresionPaciente = MedidaPresionPaciente(
                  sys: '120',
                  dia: '80',
                  bpm: '70',
                  fechaHora: '11 de junio 2023 | 07:00hrs.');
              setState(() {
                widget.onChangeMedidaPresion(medidaPresionPaciente);
              });
            },
            child: Text('Terminé'),
          ),
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
