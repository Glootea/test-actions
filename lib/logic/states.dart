import 'package:flutter/foundation.dart';
import 'package:queue/entities/export.dart';

sealed class QueueState {}

class UserUnAuthenticatedState extends QueueState {
  String? errorMessage;
  bool createGroupState;
  UserUnAuthenticatedState({this.errorMessage, this.createGroupState = false});
}

class LoadingState extends QueueState {}

class MainState extends QueueState {
  final List<LessonEntity> todayLessons;
  final bool isAdmin;

  ///Should be provided to change to new
  final Uint8List? backgroundImageDecoded;
  MainState(this.todayLessons, this.isAdmin, {this.backgroundImageDecoded});
  @override
  bool operator ==(Object other) {
    if (other is! MainState) return false;
    final r = isAdmin == other.isAdmin && listEquals(todayLessons, other.todayLessons);
    return r;
  }

  @override
  int get hashCode => todayLessons.hashCode * isAdmin.hashCode;
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
