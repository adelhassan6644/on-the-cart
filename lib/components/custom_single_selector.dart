import 'package:flutter/material.dart';
import 'package:stepOut/app/core/extensions.dart';

import '../app/core/dimensions.dart';
import '../app/core/styles.dart';
import '../app/core/text_styles.dart';

class CustomSingleSelector extends StatefulWidget {
  const CustomSingleSelector(
      {super.key,
      required this.onConfirm,
      required this.list,
      this.initialValue});
  final ValueChanged<dynamic> onConfirm;
  final List<dynamic> list;
  final int? initialValue;

  @override
  State<CustomSingleSelector> createState() => _CustomSingleSelectorState();
}

class _CustomSingleSelectorState extends State<CustomSingleSelector> {
  int? _selectedItem;
  @override
  void initState() {
    setState(() {
      _selectedItem = widget.initialValue;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        widget.list.length,
        (index) => GestureDetector(
          onTap: () {
            setState(() => _selectedItem = widget.list[index].id);
            widget.onConfirm(widget.list[index]);
          },
          child: Container(
            margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL.h),
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                vertical: Dimensions.PADDING_SIZE_SMALL.h),
            decoration: BoxDecoration(
              color: _selectedItem == widget.list[index].id
                  ? Styles.PRIMARY_COLOR.withOpacity(0.2)
                  : Styles.SMOKED_WHITE_COLOR,
              borderRadius: BorderRadius.circular(12),
              // border: Border.all(color: Styles.PRIMARY_COLOR),
            ),
            width: context.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    widget.list[index].name ?? "",
                    style: AppTextStyles.semiBold.copyWith(
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                      color: Styles.PRIMARY_COLOR,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(2),
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                      color: Styles.WHITE_COLOR,
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: Styles.PRIMARY_COLOR, width: 1)),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _selectedItem == widget.list[index].id
                          ? Styles.PRIMARY_COLOR
                          : Styles.WHITE_COLOR,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
