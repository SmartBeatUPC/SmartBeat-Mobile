import 'package:reactive_forms/reactive_forms.dart';
import 'package:smartbeat_frontend/shared/extensions/form_group_extension.dart';

class RegistroInicialForm extends FormGroup {
  FormControl<String> get email => get<String>('email');

  FormControl<String> get password => get<String>('password');

  FormControl<String> get repetirPassword => get<String>('repetirPassword');

  RegistroInicialForm()
      : super(
          fb.group({
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
          }).controls,
          validators: [
            Validators.mustMatch('password', 'repetirPassword'),
          ],
        );
}
