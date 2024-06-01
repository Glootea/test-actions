import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:queue/presentation/common_src/defined_text.dart';
import 'package:queue/presentation/common_src/expandable_block.dart';
import 'package:queue/presentation/common_src/toggle_row.dart';
import 'package:queue/presentation/screens/admin/admin_settings_screen_template.dart';
import 'package:queue/presentation/screens/admin/subpages/subject/src/lesson_koef_slider.dart';
import 'package:queue/presentation/screens/admin/subpages/subject/src/lesson_times_table.dart';
import 'package:queue/presentation/screens/admin/subpages/subject/subject_bloc.dart';
import 'package:queue/presentation/screens/today_screen/src/body/lesson_card/lesson_card_data/lesson_card_data.dart';

@RoutePage()
class SubjectAdminScreen extends StatelessWidget {
  const SubjectAdminScreen({required this.data, super.key});

  final LessonCardData data;

  @override
  Widget build(BuildContext context) {
    final cubit = SubjectEditingBloc(data);
    return BlocProvider.value(
      value: cubit,
      child: AdminSettingsScreenTemplate(
        onSubmit: () async {},
        title: 'Изменение занятия',
        headlineHeroTag: 'SubjectPage${data.lesson}',
        children: [
          const H2('Название'),
          Hero(
            tag: 'headline${data.lesson}',
            child: Material(
              type: MaterialType.transparency,
              child: TextField(
                controller: TextEditingController(text: data.lesson.name),
                maxLines: null,
                decoration: const InputDecoration(border: UnderlineInputBorder()),
              ),
            ),
          ),
          const Gap(24),
          const H2('Настройки'),
          ToggleRow(text: 'Очищать очередь после каждого занятия: ', onChanged: (value) {}, initialValue: false),
          ToggleRow(text: 'Учитывать количество работ: ', onChanged: (value) {}, initialValue: false),
          const Gap(24),
          ExpandableBlock(
            isExpanded: false,
            children: [LessonKoefSlider(initialValue: 0.5, onChanged: (value) {})],
          ),
          const H2('Даты и время занятий'),
          LessonTimesTable(times: [], onLessonAdded: (type) {}, onLessonPressed: () {}, onLessonDeleted: () {})
        ],
      ),
    );
  }
}
