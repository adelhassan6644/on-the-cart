import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/components/animated_widget.dart';
import '../../language/bloc/language_bloc.dart';
import '../widgets/about_the_app_option.dart';
import '../widgets/logout_button.dart';
import '../widgets/more_options.dart';
import '../widgets/profile_card.dart';
import '../widgets/profile_options.dart';

class More extends StatelessWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<LanguageBloc, AppState>(
        builder: (context, state) {
          return const Column(
            children: [
              Expanded(
                child: ListAnimator(
                  data: [
                    ProfileCard(),
                    MoreOptions(),
                    ProfileOptions(),
                    AboutTheAppOption(),
                    LogOutButton(),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
