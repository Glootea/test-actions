import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:queue/navigation.dart';
import 'package:queue/presentation/common_src/loading/queue_loading_container.dart';
import 'package:queue/presentation/screens/welcome/init_loading_screen/init_loading_cubit.dart';

@RoutePage()
class InitLoadingScreen extends StatelessWidget {
  const InitLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = InitLoadingCubit()..startLoading();
    return BlocProvider.value(
      value: cubit,
      child: LoadingContainer<InitLoadingCubit, LoadableState>(
        cubit: cubit,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Данные загружены', style: Theme.of(context).textTheme.titleMedium),
            const Gap(16),
            OutlinedButton(
              onPressed: () {
                if (kDebugMode) {
                  print('Can go to main screen');
                }
                AutoRouter.of(context).push(const MainRoute());
              },
              child: const Text('Продолжить'),
            ),
          ],
        ),
      ),
    );
  }
}
