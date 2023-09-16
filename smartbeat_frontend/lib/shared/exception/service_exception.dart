class ServiceException implements Exception {
  final String message;

  ServiceException({this.message = 'Ha sucedido un problema, intente luego'});

  @override
  String toString() {
    return 'ServiceException{message: $message}';
  }
}
