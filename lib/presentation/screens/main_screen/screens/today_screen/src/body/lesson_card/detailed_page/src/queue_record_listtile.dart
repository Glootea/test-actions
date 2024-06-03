import 'package:flutter/material.dart';
import 'package:queue/entities/src/queue_record.dart';
import 'package:queue/extension.dart';

class QueueRecordListtile extends StatelessWidget {
  const QueueRecordListtile(this.index, this.queueRecord, {super.key});
  final QueueRecord queueRecord;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: const RoundedRectangleBorder(),
      title: Text('${index + 1}) ${queueRecord.studentName}'),
      tilePadding: EdgeInsets.zero,
      childrenPadding: const EdgeInsets.only(left: 20),
      expandedAlignment: Alignment.topCenter,
      children: [
        Row(
          children: [
            Text(
              "Запись от ${queueRecord.time.toFullDisplayTime}${queueRecord.workCount != 0 && queueRecord.workCount != null ? ', сдано ${queueRecord.workCount} работ' : ''}",
            ),
          ],
        ),
      ],
    );
  }
}
