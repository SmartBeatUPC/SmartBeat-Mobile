import 'package:reactive_forms/reactive_forms.dart';
import 'package:smartbeat_frontend/shared/extensions/form_group_extension.dart';

class LoginForm extends FormGroup {
  FormControl<String> get usuario => get<String>('usuario');
  FormControl<String> get password => get<String>('password');

  LoginForm()
      : super(fb.group({
          'usuario': FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          'password': FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
        }).controls);
}
