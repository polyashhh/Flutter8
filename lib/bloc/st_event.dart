abstract class StudentEvent {}

class OpenProfileEvent extends StudentEvent {
  final String name;

  OpenProfileEvent(this.name);
}