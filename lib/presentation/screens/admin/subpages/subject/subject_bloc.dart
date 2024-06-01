import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/data/database/sources/local_database/local_database.dart';
import 'package:queue/presentation/screens/today_screen/src/body/lesson_card/lesson_card_data/lesson_card_data.dart';

class SubjectEditingBloc extends Cubit<SubjectData?> {
  SubjectEditingBloc(this.data) : super(null) {
    // init
  }
  final LessonCardData data;
}
