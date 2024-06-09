import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:queue/domain/user/user_cubit.dart';
import 'package:queue/navigation.dart';
import 'package:queue/presentation/common_src/loading/queue_loading_container.dart';
import 'package:queue/presentation/screens/main_screen/screens/admin/admin_settings_screen_template.dart';
import 'package:queue/presentation/screens/welcome/init_loading_screen/init_loading_cubit.dart';

@RoutePage()
class InitLoadingScreen extends StatelessWidget {
  const InitLoadingScreen({required this.userCubit, required this.intent, super.key});
  final UserCubit userCubit;
  final InitLoadingScreenIntent intent;

  @override
  Widget build(BuildContext context) {
    final cubit = InitLoadingCubit(userCubit);
    switch (intent) {
      case InitLoadingScreenIntent.createGroupHeadMaster:
        cubit.headManGroupCreationIntent();
      case InitLoadingScreenIntent.loginHeadMaster:
        cubit.headMasterLogin();
      case InitLoadingScreenIntent.signInByLink:
        cubit.headMasterLogin();
    }
    return BlocProvider.value(
      value: cubit,
      child: BlocConsumer<InitLoadingCubit, LoadableState>(
        listener: (context, state) {
          if (state is NoUserState) {
            AutoRouter.of(context).navigate(const WelcomeRoute());
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
            }
          }
        },
        builder: (context, state) => LoadingContainer<InitLoadingCubit, LoadableState>(
          cubit: cubit,
          loadingStageText: Text(state.loadingStateText ?? ''),
          child: switch (state) {
            InputDataState() => _buildInputDataPage(context, cubit),
            DefaultLoadingState() || DefaultLoadedState() || DefaultEndedState() => Scaffold(
                // scaffold here allows to use ScaffoldMessenger of [AdminSettingsScreenTemplate], that has custom insets
                body: Align(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Данные загружены', style: Theme.of(context).textTheme.titleMedium),
                      const Gap(16),
                      OutlinedButton(
                        onPressed: () {
                          AutoRouter.of(context).push(const MainRoute());
                        },
                        child: const Text('Продолжить'),
                      ),
                    ],
                  ),
                ),
              ),
            DefaultNoLoadingState() => const SizedBox(),
            _ => throw UnimplementedError('Unexpected state: ${cubit.state}'),
          },
        ),
      ),
    );
  }

  Widget _buildInputDataPage(BuildContext context, InitLoadingCubit cubit) {
    final headMasterNameKey = GlobalKey<FormState>();
    final groupController = TextEditingController();
    final headMasterController = TextEditingController();
    return Form(
      key: headMasterNameKey,
      child: AdminSettingsScreenTemplate(
        title: 'Создание группы',
        headlineHeroTag: 'title',
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.always,
            validator: (value) => value?.isEmpty ?? true ? 'Заполните поле' : null,
            decoration: const InputDecoration(labelText: 'Название группы'),
            controller: groupController,
            onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
          ),
          const Gap(16),
          TextFormField(
            autovalidateMode: AutovalidateMode.always,
            validator: (value) => value?.isEmpty ?? true ? 'Заполните поле' : null,
            decoration: const InputDecoration(labelText: 'Фамилия и имя'),
            controller: headMasterController,
            onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
          ),
        ],
        onSubmit: (localContext) async {
          if (headMasterNameKey.currentState?.validate() != true) {
            ScaffoldMessenger.of(localContext).showSnackBar(
              const SnackBar(content: Text('Поля заполнены некорректно')),
            );
          } else {
            return cubit.headManCreateGroup(
              GroupCreationData(
                groupName: groupController.value.text,
                headMasterName: headMasterController.value.text,
              ),
            );
          }
        },
      ),
    );
  }
}

enum InitLoadingScreenIntent {
  loginHeadMaster,
  createGroupHeadMaster,
  signInByLink,
}
