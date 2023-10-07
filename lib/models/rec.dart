final class Rec {
  final String userName;
  final DateTime time;

  Rec(this.userName, this.time);
}

final class UserRec extends Rec {
  UserRec(super.userName, super.time);
}
