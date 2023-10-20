import 'package:reactive_forms/reactive_forms.dart';
import 'package:smartbeat_frontend/shared/extensions/form_group_extension.dart';

class InfoMedicaForm extends FormGroup {
  FormControl<double> get talla => get<double>('height');

  FormControl<double> get peso => get<double>('weight');

  FormControl<bool> get fumasteEstaSemana => get<bool>('smoke');

  FormControl<bool> get tomasteAlcohol => get<bool>('alcohol');

  FormControl<bool> get realizasteActividadFisica => get<bool>('sedentary');

  InfoMedicaForm({
    double height = 0.0,
    double weight = 0.0,
    bool smoke = false,
    bool alcohol = false,
    bool sedentary = false,
  }) : super(fb.group({
          'height': FormControl<double>(
            validators: [
              Validators.required,
            ],
            value: height,
          ),
          'weight': FormControl<double>(
            validators: [
              Validators.required,
            ],
            value: weight,
          ),
          'smoke': FormControl<bool>(
            value: smoke,
            validators: [
              Validators.required,
            ],
          ),
          'alcohol': FormControl<bool>(
            value: alcohol,
            validators: [
              Validators.required,
            ],
          ),
          'sedentary': FormControl<bool>(
            value: sedentary,
            validators: [
              Validators.required,
            ],
          ),
        }).controls);
}
