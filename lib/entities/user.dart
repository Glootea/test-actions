@Deprecated("Use table generated class") // TODO: add studentEntity as LessonSettingEntity to avoid interacting with db directly
class UserEntity {
  final String name;
  final bool isAdmin;
  UserEntity(this.name, {this.isAdmin = false});
}
