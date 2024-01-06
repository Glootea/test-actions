import 'package:queue/entities/export.dart';
import 'package:queue/logic/states.dart';

sealed class QueueEvent {}

// --- user authentication
class FindUserEvent extends QueueEvent {}

class UserAuthenticateEvent extends QueueEvent {
  final String userID;

  UserAuthenticateEvent(this.userID);
}

class UserLogOutEvent extends QueueEvent {}

class UserAuthenticatedEvent extends QueueEvent {}

class NoUserEvent extends QueueEvent {
  String? errorMessage;
  NoUserEvent([this.errorMessage]);
}

// --- main screen ---

class CreateRegEvent extends QueueEvent {
  final String lessonName;

  CreateRegEvent(this.lessonName);
}

class DeleteRegEvent extends QueueEvent {
  final String lessonName;

  DeleteRegEvent(this.lessonName);
}

// --- upload from link

class UploadFromLinkEvent extends QueueEvent {
  final String link;

  UploadFromLinkEvent(this.link);
}

// --- invite

class InviteEvent extends QueueEvent {
  final String link;

  InviteEvent(this.link);
}

class RegisterUserEvent extends QueueEvent {
  final InviteState inviteState;

  RegisterUserEvent(this.inviteState);
}

// --- group creation

class CreateGroupIntentionEvent extends QueueEvent {}

class RegisterGroupEvent extends QueueEvent {
  final String firstName;
  final String lastName;
  final String groupName;
  final List<LessonSettingEntity> lessons;
  final List<StudentEntity> students;

  RegisterGroupEvent(this.firstName, this.lastName, this.groupName, this.lessons, this.students);
}
