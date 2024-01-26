import 'package:flutter/cupertino.dart';
import '../app/core/dimensions.dart';

class GridListAnimatorWidget extends StatelessWidget {
  const GridListAnimatorWidget(
      {this.aspectRatio,
      required this.items,
      Key? key,
      this.columnCount,
      this.padding})
      : super(key: key);
  final List<Widget> items;
  final double? aspectRatio;
  final EdgeInsetsGeometry? padding;
  final int? columnCount;
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: padding ?? EdgeInsets.only(top: 20.h),
      crossAxisCount: columnCount ?? 2,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      addAutomaticKeepAlives: true,
      mainAxisSpacing: 16.h,
      childAspectRatio: aspectRatio ?? 0.748,
      crossAxisSpacing: 16.w,
      children: items,
    );
  }
}
