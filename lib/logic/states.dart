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

// --- upload
class UploadFromLinkState extends QueueState {
  final String? message;
  final bool isLoading;
  UploadFromLinkState({required this.isLoading, this.message});
}

// --- invite

class InviteState extends QueueState {
  final String headName;
  final String groupName;
  final String userName;

  InviteState(this.headName, this.groupName, this.userName);
}
