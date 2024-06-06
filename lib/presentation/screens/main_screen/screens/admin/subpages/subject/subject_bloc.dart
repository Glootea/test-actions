import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/data/database/sources/local_database/local_database.dart';

class SubjectEditingBloc extends Cubit<SubjectData?> {
  SubjectEditingBloc(this.subjectID) : super(null) {
    // init
  }
  final int subjectID;
}
