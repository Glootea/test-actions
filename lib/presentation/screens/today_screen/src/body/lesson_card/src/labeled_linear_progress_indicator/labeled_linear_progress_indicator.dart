import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

part 'label_builder.dart';

class LabeledLinearProgressIndicator extends StatefulWidget {
  const LabeledLinearProgressIndicator({this.startValue, this.currentValue, this.endValue, this.message, super.key});
  final int? startValue;
  final int? currentValue;
  final int? endValue;
  final String? message;
  @override
  State<LabeledLinearProgressIndicator> createState() => _LabeledLinearProgressIndicatorState();
}

class _LabeledLinearProgressIndicatorState extends State<LabeledLinearProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    //TODO: fix not update on new data
    final value = widget.currentValue == null
        ? 0.0
        : 1.0 - (widget.currentValue!) - (widget.startValue!) / (widget.endValue!) - (widget.startValue!);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(8),
        LinearProgressIndicator(
          value: value,
          color: Theme.of(context).colorScheme.primary,
          backgroundColor: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.5),
          borderRadius: BorderRadius.circular(2),
          minHeight: value != 0 ? 4 : 2,
        ),
        _LabelBuilder(
          message: widget.message,
          // message:
          //     'jkdrhnghnkjfdngjkdnfgjkhdfldkgjhgkjdfngjfdnvjfhgjfhgkjnfjknfvjhkjfdgbnsjkfbgkjlfbgkjdbfsgkjbfdjgnfkjdnvkjlfnvkljfdsnvjkvnfkjgkjdfgkjfdngkjln',
          value: value,
          valuePresentation: widget.currentValue?.toString(),
          style: Theme.of(context).textTheme.bodyMedium,
          expandIcon: Icons.more_horiz_outlined,
          iconSize: Checkbox.width,
        ),
      ],
    );
  }
}
