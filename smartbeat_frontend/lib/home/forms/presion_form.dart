import 'package:reactive_forms/reactive_forms.dart';
import 'package:smartbeat_frontend/shared/extensions/form_group_extension.dart';

class PresionForm extends FormGroup {
  FormControl<int> get bloodPressureSistolic =>
      get<int>('bloodPressureSistolic');

  FormControl<int> get bloodPressureDiastolic =>
      get<int>('bloodPressureDiastolic');

  FormControl<int> get bloodPresheartRatesureDiastolic =>
      get<int>('bloodPresheartRatesureDiastolic');

  PresionForm()
      : super(fb.group({
          'bloodPressureSistolic': FormControl<int>(
            validators: [
              Validators.required,
            ],
          ),
          'bloodPressureDiastolic': FormControl<int>(
            validators: [
              Validators.required,
            ],
          ),
          'bloodPresheartRatesureDiastolic': FormControl<int>(
            validators: [
              Validators.required,
            ],
          ),
        }).controls);
}
