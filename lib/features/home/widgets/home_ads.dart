import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/extensions.dart';
import 'package:stepOut/components/shimmer/custom_shimmer.dart';
import 'package:stepOut/features/home/models/ads_model.dart';

import '../../../components/custom_network_image.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../bloc/home_ads_bloc.dart';

class HomeAds extends StatelessWidget {
  const HomeAds({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeAdsBloc, AppState>(
      builder: (context, state) {
        if (state is Start) {
          // AdsModel model = state.model as AdsModel;
          return CarouselSlider.builder(
            options: CarouselOptions(
              height: context.height * 0.20,
              disableCenter: true,
              pageSnapping: true,
              autoPlay: true,
              aspectRatio: 1.0,
              viewportFraction: 0.8,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                context.read<HomeAdsBloc>().updateIndex(index);
              },
            ),
            disableGesture: true,
            itemCount: 4,
            // itemCount: model.data?.length ?? 0,
            itemBuilder: (context, index, _) {
              return InkWell(
                onTap: () {
                  CustomNavigator.push(Routes.itemDetails, arguments: 0);
                },
                child: CustomNetworkImage.containerNewWorkImage(
                  image: "",
                  // image: model.data?[index].image ?? "",
                  height: context.height * 0.275,
                  width: context.width,
                  radius: 20,
                  fit: BoxFit.cover,
                ),
              );
            },
            carouselController: context.read<HomeAdsBloc>().bannerController,
          );
        }
        if (state is Loading) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
            child: CustomShimmerContainer(
              height: context.height * 0.2,
              width: context.width,
              radius: 12,
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
