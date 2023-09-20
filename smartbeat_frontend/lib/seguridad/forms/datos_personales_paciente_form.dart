import 'package:reactive_forms/reactive_forms.dart';
import 'package:smartbeat_frontend/shared/extensions/form_group_extension.dart';

class DatosPersonalesPacienteForm extends FormGroup {
  FormControl<String> get nombre => get<String>('nombre');

  FormControl<String> get apellidos => get<String>('apellidos');

  FormControl<String> get edad => get<String>('edad');

  FormControl<String> get dni => get<String>('dni');

  FormControl<String> get telefono => get<String>('telefono');

  FormControl<String> get nacionalidad => get<String>('nacionalidad');

  FormControl<String> get genero => get<String>('genero');

  DatosPersonalesPacienteForm()
      : super(fb.group({
          'nombre': FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          'dni': FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          'telefono': FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          'apellidos': FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          'edad': FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          'nacionalidad': FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          'genero': FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
        }).controls);
}
