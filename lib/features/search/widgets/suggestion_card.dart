import 'package:flutter/material.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/text_styles.dart';
import 'package:stepOut/features/search/model/suggestion_model.dart';

import '../../../app/core/styles.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';

class SuggestionCard extends StatelessWidget {
  const SuggestionCard({super.key, required this.suggestionItem});
  final SuggestionItem suggestionItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => CustomNavigator.push(Routes.searchResult,
          arguments: suggestionItem.title),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Styles.DISABLED))),
        child: Text(
          suggestionItem.title ?? "",
          style: AppTextStyles.medium.copyWith(
            fontSize: 14,
            color: Styles.DISABLED,
          ),
        ),
      ),
    );
  }
}
