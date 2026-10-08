class ValidateNameUseCase {
  bool call(String name) {
    return name.trim().isNotEmpty;
  }
}