import 'package:reactive_forms/reactive_forms.dart';
import 'package:smartbeat_frontend/shared/extensions/form_group_extension.dart';

class InfoMedicaForm extends FormGroup {
  FormControl<double> get talla => get<double>('talla');

  FormControl<double> get peso => get<double>('peso');

  FormControl<double> get imc => get<double>('imc');

  FormControl<bool> get fumasteEstaSemana => get<bool>('fumasteEstaSemana');

  FormControl<bool> get tomasteAlcohol => get<bool>('tomasteAlcohol');

  FormControl<bool> get realizasteActividadFisica =>
      get<bool>('realizasteActividadFisica');

  InfoMedicaForm()
      : super(fb.group({
          'talla': FormControl<double>(
            validators: [
              Validators.required,
            ],
          ),
          'peso': FormControl<double>(
            validators: [
              Validators.required,
            ],
          ),
          'imc': FormControl<double>(
            validators: [
              Validators.required,
            ],
          ),
          'fumasteEstaSemana': FormControl<bool>(
            value: false,
            validators: [
              Validators.required,
            ],
          ),
          'tomasteAlcohol': FormControl<bool>(
            value: false,
            validators: [
              Validators.required,
            ],
          ),
          'realizasteActividadFisica': FormControl<bool>(
            value: false,
            validators: [
              Validators.required,
            ],
          ),
        }).controls);
}
