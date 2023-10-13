import 'package:reactive_forms/reactive_forms.dart';
import 'package:smartbeat_frontend/shared/extensions/form_group_extension.dart';

class LoginForm extends FormGroup {
  FormControl<String> get email => get<String>('email');

  FormControl<String> get password => get<String>('password');

  FormControl<bool> get recordarDatos => get<bool>('recordarDatos');

  LoginForm()
      : super(fb.group({
          'email': FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          'password': FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          'recordarDatos': FormControl<bool>(value: false),
        }).controls);
}
