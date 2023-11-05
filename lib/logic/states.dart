import 'package:queue/entities/lesson.dart';

sealed class QueueState {}

class UserUnAuthenticatedState extends QueueState {
  String? errorMessage;
  UserUnAuthenticatedState(this.errorMessage);
}

class LoadingState extends QueueState {}

class MainState extends QueueState {
  final List<LessonEntity> todayLessons;

  MainState(this.todayLessons);
}

class UploadFromLinkState extends QueueState {
  final String? message;
  final bool isLoading;
  UploadFromLinkState({required this.isLoading, this.message});
}
