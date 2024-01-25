import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/components/custom_app_bar.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/core/text_styles.dart';
import '../../../../app/localization/language_constant.dart';
import '../../../../data/config/di.dart';
import '../bloc/register_bloc.dart';
import '../repo/register_repo.dart';
import '../widgets/register_body_widget.dart';

class Register extends StatelessWidget {
  const Register({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RegisterBloc(repo: sl<RegisterRepo>())..add(Remember()),
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: Column(
          children: [
            Text(
              getTranslated("signup_header"),
              textAlign: TextAlign.start,
              style: AppTextStyles.semiBold.copyWith(
                fontSize: 24,
              ),
            ),
            const RegisterBodyWidget(),
          ],
        ),
      ),
    );
  }
}
