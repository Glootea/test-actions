import 'package:queue/models/lesson.dart';

abstract class QueueState {}

class UserUnAuthenticatedState extends QueueState {
  String? errorMessage;
  UserUnAuthenticatedState(this.errorMessage);
}

class LoadingState extends QueueState {}

class MainState extends QueueState {
  final List<Lesson> todaysLessons;

  MainState(this.todaysLessons);
}
