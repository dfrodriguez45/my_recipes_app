abstract class Failure {
  final String? message;

  Failure({this.message});
}

class LocalFailure extends Failure {
  LocalFailure(String message) : super(message: message);
}