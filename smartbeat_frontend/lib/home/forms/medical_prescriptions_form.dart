import 'package:reactive_forms/reactive_forms.dart';
import 'package:smartbeat_frontend/shared/extensions/form_group_extension.dart';

class MedicalPrescriptionForm extends FormGroup {
  FormControl<String> get medicament => get<String>('medicament');

  FormControl<String> get dosage => get<String>('dosage');

  FormControl<String> get via => get<String>('via');

  FormControl<String> get frequency => get<String>('frequency');

  FormControl<String> get duration => get<String>('duration');

  MedicalPrescriptionForm()
      : super(fb.group({
          'medicament': FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          'dosage': FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          'via': FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          'frequency': FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          'duration': FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
        }).controls);
}
