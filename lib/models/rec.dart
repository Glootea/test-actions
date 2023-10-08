final class Rec {
  final String userName;
  final DateTime time;
  @override
  bool operator ==(Object other) {
    if (other is Rec || other is UserRec) {
      if (identical(this, other)) return true;
      Rec otherRec = other as Rec;
      if (time == otherRec.time && userName == otherRec.userName) return true;
      return false;
    }
    return false;
  }

  Rec(
    this.userName,
    this.time,
  );

  @override
  int get hashCode => userName.hashCode * time.hashCode;
}

final class UserRec extends Rec {
  final bool isOnline;
  UserRec(super.userName, super.time, [this.isOnline = true]);
  static UserRec fromString(String str, String userName) {
    List<String> list = str.split(',').map((e) => e.trim()).toList();
    return UserRec(userName, DateTime.parse(list[0]), bool.parse(list[1]));
  }
}
