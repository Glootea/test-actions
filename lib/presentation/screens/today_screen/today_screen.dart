import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/new_domain/today_screen_cubit.dart';
import 'package:queue/presentation/common_src/loading/queue_loading_container.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TodayScreenCubit>();
    return LoadingContainer<TodayScreenCubit, MainScreenState>(
        cubit: cubit,
        child: Container(
          color: Colors.white,
        ));
  }
}
