abstract class StudentState {}

class StudentInitial extends StudentState {}

class NavigateToProfileState extends StudentState {
  final String name;

  NavigateToProfileState(this.name);
}

class ErrorState extends StudentState {
  final String message;

  ErrorState(this.message);
}