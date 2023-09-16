import 'package:reactive_forms/reactive_forms.dart';

extension FormGroupExtension on FormGroup {
  FormControl<T> get<T>(String name) => control(name) as FormControl<T>;
}
