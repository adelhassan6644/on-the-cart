import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/components/custom_app_bar.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/core/text_styles.dart';
import '../../../../app/localization/language_constant.dart';
import '../../../../data/config/di.dart';
import '../bloc/login_bloc.dart';
import '../repo/login_repo.dart';
import '../widgets/login_body_widget.dart';

class Login extends StatelessWidget {
  final bool fromMain;

  const Login({Key? key, required this.fromMain}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(repo: sl<LoginRepo>())..add(Remember()),
      child: Scaffold(
        appBar: CustomAppBar(
          withBack: fromMain,
        ),
        body: Column(
          children: [
            Text(
              getTranslated("login_header"),
              textAlign: TextAlign.start,
              style: AppTextStyles.semiBold.copyWith(
                fontSize: 24,
              ),
            ),
            const LoginBodyWidget(),
          ],
        ),
      ),
    );
  }
}
