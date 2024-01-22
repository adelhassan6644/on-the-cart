import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stepOut/features/splash/repo/splash_repo.dart';
import '../../../app/core/app_event.dart';
import '../../../app/core/images.dart';
import '../../../app/core/styles.dart';
import '../../../data/config/di.dart';
import '../bloc/splash_bloc.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc(repo: sl<SplashRepo>())..add(Click()),
      child: BlocBuilder<SplashBloc, AppState>(
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Styles.SPLASH_BACKGROUND_COLOR,
              body: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      height: context.height,
                      width: context.width,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Styles.SPLASH_BACKGROUND_COLOR),
                      child: const SizedBox()),
                  Image.asset(
                    Images.splash,
                    width: context.width * 0.5,
                    height: context.height * 0.2,
                  )
                      .animate()
                      .slideX()
                      .then(delay: 100.ms) // baseline=800ms
                      .shake()
                      .then(delay: 200.ms)
                      .shimmer(duration: 1000.ms, curve: Curves.easeInCirc),
                ],
              ));
        },
      ),
    );
  }
}
