import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/extensions.dart';
import 'package:stepOut/components/animated_widget.dart';
import '../../language/bloc/language_bloc.dart';
import '../widgets/more_options.dart';
import '../widgets/profile_card.dart';

class More extends StatelessWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, AppState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: ListAnimator(
                customPadding: EdgeInsets.only(
                    top: (Dimensions.PADDING_SIZE_DEFAULT.h +
                        context.toPadding)),
                data: const [
                  ProfileCard(),
                  MoreOptions(),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
