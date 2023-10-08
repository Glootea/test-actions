abstract class QueueEvent {}

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

// --- main screen


