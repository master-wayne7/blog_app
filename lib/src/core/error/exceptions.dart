// ignore_for_file: public_member_api_docs, sort_constructors_first
class ServerExceptions implements Exception {
  final String message;

  const ServerExceptions(this.message);

  @override
  String toString() => message;
}
