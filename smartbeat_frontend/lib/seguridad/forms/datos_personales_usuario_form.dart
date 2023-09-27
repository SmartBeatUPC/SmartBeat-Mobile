import 'package:reactive_forms/reactive_forms.dart';
import 'package:smartbeat_frontend/shared/extensions/form_group_extension.dart';

class DatosPersonalesUsuarioForm extends FormGroup {
  FormControl<String> get name => get<String>('name');

  FormControl<String> get lastName => get<String>('lastName');

  FormControl<String> get age => get<String>('age');

  FormControl<String> get dni => get<String>('dni');

  FormControl<String> get telefono => get<String>('phone');

  FormControl<String> get phone => get<String>('nationality');

  FormControl<String> get gender => get<String>('gender');

  DatosPersonalesUsuarioForm()
      : super(fb.group({
          'name': FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          'dni': FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          'phone': FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          'lastName': FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          'age': FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          'nationality': FormControl<String>(),
          'gender': FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
        }).controls);
}
