import 'package:flutter/material.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/components/custom_network_image.dart';
import 'package:stepOut/features/stores/model/stores_model.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';

class StoreCard extends StatelessWidget {
  const StoreCard({super.key, this.store});
  final StoreItem? store;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: InkWell(
        onTap: () => CustomNavigator.push(Routes.items, arguments: store),
        child: CustomNetworkImage.containerNewWorkImage(
            image: store?.image ?? "", height: 75.h, radius: 12),
      ),
    );
  }
}
