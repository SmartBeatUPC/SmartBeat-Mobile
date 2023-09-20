import 'package:reactive_forms/reactive_forms.dart';
import 'package:smartbeat_frontend/shared/extensions/form_group_extension.dart';

class RegistroForm extends FormGroup {
  FormControl<String> get email => get<String>('email');

  FormControl<String> get password => get<String>('password');

  FormControl<String> get repetirPassword => get<String>('repetirPassword');

  RegistroForm()
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
          'repetirPassword': FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
        }).controls);
}
