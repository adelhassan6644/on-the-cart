import 'package:flutter/material.dart';
import '../../app/core/styles.dart';
import '../../components/custom_images.dart';

class BottomNavBarItem extends StatelessWidget {
  final String? imageIcon;
  final String? svgIcon;
  final VoidCallback onTap;
  final bool isSelected, withIconColor, withDot;
  final String? label;
  final double? width;
  final double? height;

  const BottomNavBarItem({
    super.key,
    this.imageIcon,
    this.svgIcon,
    this.label,
    this.isSelected = false,
    this.withDot = false,
    this.withIconColor = true,
    required this.onTap,
    this.width = 24,
    this.height = 24,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: onTap,
      child: SizedBox(
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (withDot)
              AnimatedCrossFade(
                  crossFadeState: isSelected
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 200),
                  firstChild: Center(
                      child: Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(bottom: 4),
                    decoration: const BoxDecoration(
                        color: Styles.PRIMARY_COLOR, shape: BoxShape.circle),
                    child: const SizedBox(),
                  )),
                  secondChild: const SizedBox(
                    height: 6,
                  )),
            svgIcon != null
                ? customImageIconSVG(
                    imageName: svgIcon!,
                    color: isSelected
                        ? Styles.PRIMARY_COLOR
                        : withIconColor
                            ? Styles.DISABLED
                            : null,
                    width: width,
                    height: height)
                : customImageIcon(
                    imageName: imageIcon!,
                    height: height,
                    color: isSelected ? Styles.PRIMARY_COLOR : Styles.DISABLED,
                    width: width,
                  ),
            if (label != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  label!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? Styles.PRIMARY_COLOR : Styles.DISABLED,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 11,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
