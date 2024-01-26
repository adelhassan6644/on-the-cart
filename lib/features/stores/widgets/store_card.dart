import 'package:flutter/material.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/components/custom_network_image.dart';
import 'package:stepOut/features/stores/model/stores_model.dart';

class StoreCard extends StatelessWidget {
  const StoreCard({super.key, this.store});
  final StoreItem? store;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: InkWell(
        child: CustomNetworkImage.containerNewWorkImage(
            image: store?.image ?? "", height: 75.h, radius: 12),
      ),
    );
  }
}
