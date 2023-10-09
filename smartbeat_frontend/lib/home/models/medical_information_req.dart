import 'package:smartbeat_frontend/home/models/req_medical_information.dart';
import 'package:smartbeat_frontend/home/models/req_medical_record.dart';

class MedicalInformationReq {
  final RequestMedicalRecord requestMedicalRecordDto;
  final ReqMedicalInformation reqMedicalInformation;

  const MedicalInformationReq({
    required this.requestMedicalRecordDto,
    required this.reqMedicalInformation,
  });

  Map<String, dynamic> toMap() => {
    'requestMedicalRecordDto': requestMedicalRecordDto.toMap(),
    'requestMedicalInformationDto': reqMedicalInformation.toMap()
  };
}
