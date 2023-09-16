import 'package:reactive_forms/reactive_forms.dart';

class FormConfig {
  static Map<String, String Function(Object)> validationMessages = {
    ValidationMessage.required: (error) => 'El campo es requerido',
    ValidationMessage.email: (error) => 'El campo debe ser de formato de email',
    ValidationMessage.mustMatch: (error) => 'El campo no coincide',
    ValidationMessage.pattern: (error) =>
        'El campo no cumple lo minimo requerido',
    ValidationMessage.minLength: (error) =>
        'El campo no cumple la longitud minima',
    ValidationMessage.maxLength: (error) =>
    'Longitud del campo excedida'
  };
}
