// ignore_for_file: non_constant_identifier_names, constant_identifier_names

final Map<String, String> STUDENTS = Map.fromEntries(
    const String.fromEnvironment("students")
        .replaceAll("{", "")
        .replaceAll("}", "")
        .split(',')
        .map((e) {
  List<String> params = e.split(':');
  return MapEntry(params[0].trim(), params[1].trim());
}));

final String TABLEURL = const String.fromEnvironment("tableUrl").trim();

final List<String> ADMINS = (const String.fromEnvironment("admins"))
    .replaceFirst("[", "")
    .replaceFirst("]", "")
    .split(",")
    .map((e) => e.trim())
    .toList();
