import 'package:reactive_forms/reactive_forms.dart';
import 'package:smartbeat_frontend/shared/extensions/form_group_extension.dart';

class DiagnosticoForm extends FormGroup {
  FormControl<String> get diagnostico =>
      get<String>('diagnosticResult');

  DiagnosticoForm()
      : super(fb.group({
          'diagnosticResult': FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
        }).controls);
}
