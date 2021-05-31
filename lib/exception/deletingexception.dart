class del_exception implements Exception {
  String message;
  del_exception(this.message);

  @override
  String toString() {
    return message;
  }
}
