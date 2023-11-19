import 'package:flutter/foundation.dart';
import 'package:queue/entities/lesson.dart';

sealed class QueueState {}

class UserUnAuthenticatedState extends QueueState {
  String? errorMessage;
  UserUnAuthenticatedState(this.errorMessage);
}

class LoadingState extends QueueState {}

class MainState extends QueueState {
  final List<LessonEntity> todayLessons;
  final bool isAdmin;
  MainState(this.todayLessons, this.isAdmin);
  @override
  bool operator ==(Object other) {
    if (other is! MainState) return false;
    final r = isAdmin == other.isAdmin &&
        listEquals(todayLessons, other.todayLessons);
    print(r);
    return r;
  }
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
