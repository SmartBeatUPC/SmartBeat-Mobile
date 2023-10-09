import 'package:smartbeat_frontend/home/models/Patologia.dart';

class PatologiasReq {
  final List<Patologia> patologias;

  PatologiasReq({
    required this.patologias,
  });

  Map<String, dynamic> toMap() => {
        'pathologies': patologias.map((element) {
          return element.toMap();
        }).toList(),
      };
}
