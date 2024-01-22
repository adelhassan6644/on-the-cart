import 'package:flutter/material.dart';
import 'package:stepOut/app/core/extensions.dart';
import 'package:stepOut/components/animated_widget.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import 'package:stepOut/navigation/routes.dart';
import '../../../app/core/dimensions.dart';
import '../../../app/core/images.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_images.dart';
import '../widgets/step_widget.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  nextPage() {
    pageController.animateToPage(pageController.page!.toInt() + 1,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    currentIndex = pageController.page!.toInt();
  }

  List<String> images = [
    Images.onBoarding1,
    Images.onBoarding2,
    Images.onBoarding3,
    Images.onBoarding4,
  ];

  List<String> titles = [
    "on_boarding_header_1",
    "on_boarding_header_2",
    "on_boarding_header_3",
    "on_boarding_header_4",
  ];
  List<String> descriptions = [
    "on_boarding_description_1",
    "on_boarding_description_2",
    "on_boarding_description_3",
    "on_boarding_description_4",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  onPageChanged: ((index) => setState(() {
                        currentIndex = index;
                      })),
                  itemBuilder: (_, i) => ListAnimator(
                    data: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                              height: context.height * 0.75,
                              width: context.width,
                              padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                                vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
                              ),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  image: AssetImage(images[i]),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: context.toPadding,
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: InkWell(
                                      onTap: () => CustomNavigator.push(
                                          Routes.DASHBOARD,
                                          clean: true),
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Dimensions
                                                  .PADDING_SIZE_SMALL.w,
                                              vertical: Dimensions
                                                  .PADDING_SIZE_EXTRA_SMALL.h),
                                          decoration: BoxDecoration(
                                              color: const Color(0xFF343131)
                                                  .withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(24)),
                                          child: Text(
                                            getTranslated("skip"),
                                            textAlign: TextAlign.center,
                                            style: AppTextStyles.medium
                                                .copyWith(
                                                    fontSize: 16,
                                                    height: 1,
                                                    color: Styles.WHITE_COLOR),
                                          )),
                                    ),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  customImageIcon(
                                    imageName: Images.logo,
                                    width: 60,
                                    height: 60,
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),

                                  ///header
                                  Text(
                                    "On the cart",
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.semiBold.copyWith(
                                        fontSize: 24,
                                        color: Styles.WHITE_COLOR),
                                  ),
                                ],
                              )),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                              vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
                            ),
                            decoration: const BoxDecoration(
                                color: Styles.WHITE_COLOR,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(22),
                                  topLeft: Radius.circular(22),
                                )),
                            child: Column(
                              children: [
                                ///header
                                Text(
                                  getTranslated(titles[i]),
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.semiBold.copyWith(
                                      fontSize: 24,
                                      color: Styles.PRIMARY_COLOR),
                                ),

                                SizedBox(
                                  height: 12.h,
                                ),

                                ///description
                                Text(
                                  getTranslated(descriptions[i]),
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.medium.copyWith(
                                      fontSize: 14, color: Styles.ACCENT_COLOR),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  if (currentIndex < 3) {
                    setState(() {
                      nextPage();
                    });
                  } else {
                    CustomNavigator.push(Routes.DASHBOARD, clean: true);
                  }
                },
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: StepWidget(
                    value: ((currentIndex + 1) / 4),
                    backgroundColor: Styles.SMOKED_WHITE_COLOR,
                    foregroundColor: Styles.PRIMARY_COLOR,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
