import 'package:reactive_forms/reactive_forms.dart';
import 'package:smartbeat_frontend/shared/extensions/form_group_extension.dart';

class LoginForm extends FormGroup {
  FormControl<String> get dni => get<String>('dni');
  FormControl<String> get nombres => get<String>('nombres');

  LoginForm()
      : super(fb.group({
          'dni': FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          'nombres': FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
        }).controls);
}
