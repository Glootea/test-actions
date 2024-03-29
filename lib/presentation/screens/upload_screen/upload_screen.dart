import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/events.dart';
import 'package:queue/logic/states.dart';
import 'package:queue/presentation/screens/upload_screen/widgets/create_rec_page.dart';
import 'package:queue/presentation/screens/upload_screen/widgets/loading_rec_page.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QueueBloc, QueueState>(buildWhen: (previous, current) {
      if (previous is UploadFromLinkState && current is UploadFromLinkState) {
        return previous.message != current.message || previous.isLoading != current.isLoading;
      }
      return false;
    }, builder: ((context, state) {
      try {
        state = state as UploadFromLinkState;
        return Scaffold(
          // data: Theme.of(context).copyWith(dividerTheme: const DividerThemeData(color: Colors.transparent)),
          body: Scaffold(
            body: SafeArea(child: (state.isLoading) ? const LoadingRecPage() : CreatedRecPage(state)),
            persistentFooterAlignment: AlignmentDirectional.bottomEnd,
            persistentFooterButtons: [
              OutlinedButton(
                  onPressed: () {
                    context.go('/');
                    context.read<QueueBloc>().add(FindUserEvent());
                  },
                  child: Text("OK", style: Theme.of(context).textTheme.bodyMedium)),
            ],
          ),
        );
      } catch (e) {
        log(e.toString());
        return const Scaffold();
      }
    }));
  }
}
