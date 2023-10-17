import 'package:smartbeat_frontend/home/models/presion_req.dart';
import 'package:smartbeat_frontend/home/models/req_medical_information.dart';
import 'package:smartbeat_frontend/home/models/req_medical_record.dart';

class MedicalInformationReq {
  final RequestMedicalRecord requestMedicalRecordDto;
  final ReqMedicalInformation reqMedicalInformation;
  final PresionReq reqPresion;

  const MedicalInformationReq({
    required this.requestMedicalRecordDto,
    required this.reqMedicalInformation,
    required this.reqPresion,
  });

  Map<String, dynamic> toMap() => {
        'requestMedicalRecordDto': requestMedicalRecordDto.toMap(),
        'requestMedicalInformationDto': reqMedicalInformation.toMap(),
        'requestPpgDto': reqPresion.toMap(),
      };
}
