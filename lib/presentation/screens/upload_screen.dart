import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/events.dart';
import 'package:queue/logic/states.dart';

class UploadScreen extends StatefulWidget {
  final String? link;
  const UploadScreen(this.link, {super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  @override
  void initState() {
    if (widget.link != null && widget.link!.isNotEmpty) {
      context.read<QueueBloc>().add(UploadFromLinkEvent(widget.link!));
    }

    super.initState();
  }

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
        return Theme(
          data: Theme.of(context).copyWith(
            dividerTheme: const DividerThemeData(color: Colors.transparent),
          ),
          child: Scaffold(
            body: SafeArea(
                child: (state.isLoading)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Загрузка записи", style: Theme.of(context).textTheme.headlineLarge),
                          const Gap(64),
                          const Align(
                              child: SizedBox(
                            height: 100,
                            width: 100,
                            child: CircularProgressIndicator(),
                          )),
                        ],
                      )
                    : Center(
                        // TODO: show additional info like place in queue and previous person
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Спасибо за помощь!",
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            const Gap(64),
                            Text(
                              state.message ?? '',
                              style: Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )),
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
