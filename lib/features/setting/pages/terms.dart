import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/app/core/extensions.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/features/setting/model/setting_model.dart';
import '../../../app/core/dimensions.dart';
import '../../../app/core/images.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_loading.dart';
import '../../../components/empty_widget.dart';
import '../bloc/setting_bloc.dart';

class Terms extends StatelessWidget {
  const Terms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated("terms_conditions"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: BlocBuilder<SettingBloc, AppState>(
              builder: (context, state) {
                if (state is Loading) {
                  return const CustomLoading();
                }

                // if (state is Done) {
                  return ListAnimator(
                    customPadding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                    ),
                    data: [
                      // Center(
                      //   child: Image.asset(
                      //     Images.splash,
                      //     width: context.width * 0.3,
                      //     height: context.height * 0.23,
                      //   ),
                      // ),
                      SizedBox(
                        height: 16.h,
                      ),
                      // (state.model as SettingModel).data?.terms
                      HtmlWidget(
                            "${"<h1> Privacy Policy for [YOUR SITE TITLE]</h1> <p> If you require any more information or have any questions about our privacy policy, please feel free to contact us by email at [CONTACT@YOUREMAIL.COM].</p> <p>At [YOUR SITE URL] we consider the privacy of our visitors to be extremely important. This privacy policy document describes in detail the types of personal information is collected and recorded by [YOUR SITE URL] and how we use it. </p> <p> <b>Log Files</b><br /> Like many other Web sites, [YOUR SITE URL] makes use of log files. These files merely logs visitors to the site – usually a standard procedure for hosting companies and a part of hosting services's analytics. The information inside the log files includes internet protocol (IP) addresses, browser type, Internet Service Provider (ISP), date/time stamp, referring/exit pages, and possibly the number of clicks. This information is used to analyze trends, administer the site, track user's movement around the site, and gather demographic information. IP addresses, and other such information are not linked to any information that is personally identifiable. </p> <p> <b>Cookies and Web Beacons</b><br />[YOUR SITE URL] uses cookies to store information about visitors' preferences, to record user-specific information on which pages the site visitor accesses or visits, and to personalize or customize our web page content based upon visitors' browser type or other information that the visitor sends via their browser. </p> <p><b>DoubleClick DART Cookie</b><br /> </p> <p> → Google, as a third party vendor, uses cookies to serve ads on [YOUR SITE URL].<br /><br /> → Google's use of the DART cookie enables it to serve ads to our site's visitors based upon their visit to [YOUR SITE URL] and other sites on the Internet. <br /><br /> → Users may opt out of the use of the DART cookie by visiting the Google ad and content network privacy policy at the following URL – <a href="}"),
                      SizedBox(height: 24.h),
                    ],
                  );
                // }

                if (state is Empty) {
                  return ListAnimator(
                    customPadding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                    ),
                    data: [
                      SizedBox(
                        height: 24.h,
                      ),
                      EmptyState(
                        txt: getTranslated("something_went_wrong"),
                      ),
                      SizedBox(height: 24.h),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
