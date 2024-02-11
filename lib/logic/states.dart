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
  final String? message;
  final bool updateEnabled;
  final bool processingActive;

  ///Should be provided to change to new
  final Uint8List? backgroundImageDecoded;
  MainState(this.todayLessons, this.isAdmin, this.updateEnabled, this.processingActive,
      {this.backgroundImageDecoded, this.message});
  @override
  bool operator ==(Object other) {
    if (other.runtimeType != MainState) return false;
    if (other is! MainState) return false;
    final r = isAdmin == other.isAdmin &&
        listEquals(todayLessons, other.todayLessons) &&
        backgroundImageDecoded == other.backgroundImageDecoded &&
        updateEnabled == other.updateEnabled &&
        processingActive == other.processingActive;
    return r;
  }

  @override
  int get hashCode => todayLessons.hashCode * isAdmin.hashCode;
}

class ShowQRCodeState extends MainState {
  final String data;
  ShowQRCodeState(this.data, super.todayLessons, super.isAdmin, super.updateEnabled, super.processingActive);
  @override
  bool operator ==(Object other) {
    if (other is! ShowQRCodeState) return false;
    final r = data == other.data &&
        listEquals(todayLessons, other.todayLessons) &&
        isAdmin == other.isAdmin &&
        message == other.message &&
        backgroundImageDecoded == other.backgroundImageDecoded &&
        processingActive == other.processingActive;
    return r;
  }

  @override
  int get hashCode => super.hashCode * data.hashCode;
}

// --- upload
class UploadFromLinkState extends QueueState {
  final String? message;
  final bool isLoading;
  final bool loadedPosition;
  UploadFromLinkState({required this.isLoading, required this.loadedPosition, this.message});
}

// --- invite

class ReceivedInviteState extends QueueState {
  final String tableID;
  ReceivedInviteState(this.tableID);
}

// --- admin

class AdminSettingState extends QueueState {
  final int index;
  AdminSettingState(this.index);
}
