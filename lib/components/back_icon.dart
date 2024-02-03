import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:stepOut/navigation/custom_navigation.dart';
import '../app/core/styles.dart';
import '../app/core/svg_images.dart';
import 'custom_images.dart';

class FilteredBackIcon extends StatelessWidget {
  const FilteredBackIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => CustomNavigator.pop(),
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(100),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(100)),
            child: const Icon(
              Icons.arrow_back,
              size: 20,
              color: Styles.WHITE_COLOR,
            ),
          ),
        ),
      ),
    );
  }
}
