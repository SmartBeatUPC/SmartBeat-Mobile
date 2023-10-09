import 'package:reactive_forms/reactive_forms.dart';
import 'package:smartbeat_frontend/shared/extensions/form_group_extension.dart';

class PresionForm extends FormGroup {
  FormControl<double> get bloodPressureSistolic =>
      get<double>('bloodPressureSistolic');

  FormControl<double> get bloodPressureDiastolic =>
      get<double>('bloodPressureDiastolic');

  FormControl<int> get bloodPresheartRatesureDiastolic =>
      get<int>('bloodPresheartRatesureDiastolic');

  PresionForm()
      : super(fb.group({
          'bloodPressureSistolic': FormControl<double>(
            validators: [
              Validators.required,
            ],
          ),
          'bloodPressureDiastolic': FormControl<double>(
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
