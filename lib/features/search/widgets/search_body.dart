import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/extensions.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/components/animated_widget.dart';
import 'package:stepOut/components/empty_widget.dart';
import 'package:stepOut/components/shimmer/custom_shimmer.dart';
import 'package:stepOut/features/search/bloc/search_bloc.dart';
import 'package:stepOut/features/search/model/suggestion_model.dart';

import '../../../app/core/images.dart';
import '../../../app/core/styles.dart';
import 'suggestion_card.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, AppState>(
      builder: (context, state) {
        if (state is Start) {
          return Expanded(
            child: ListAnimator(
              customPadding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
              data: [
                EmptyState(
                  txt: getTranslated("search_for_what_you_want"),
                  isSvg: false,
                  img: Images.startSearch,
                ),
              ],
            ),
          );
        }
        if (state is Done) {
          List<SuggestionItem> items = (state.model as SuggestionModel).data!;
          return Expanded(
            child: ListAnimator(
              customPadding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
              data: List.generate(
                  items.length,
                  (index) => SuggestionCard(
                        suggestionItem: items[index],
                      )),
            ),
          );
        }
        if (state is Loading) {
          return Expanded(
            child: ListAnimator(
              customPadding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
              data: List.generate(
                5,
                (index) => Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: const BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Styles.DISABLED))),
                  child: CustomShimmerContainer(
                    height: 20,
                    width: context.width * 0.7,
                  ),
                ),
              ),
            ),
          );
        }
        if (state is Empty) {
          return Expanded(
            child: ListAnimator(
              customPadding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
              data: [
                EmptyState(
                  txt: getTranslated("there_is_no_result"),
                  isSvg: false,
                  img: Images.emptySearch,
                ),
              ],
            ),
          );
        }
        if (state is Error) {
          return Expanded(
            child: ListAnimator(
              customPadding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
              data: [
                EmptyState(
                  txt: getTranslated("something_went_wrong"),
                  isSvg: false,
                  img: Images.emptySearch,
                ),
              ],
            ),
          );
        }
        return Expanded(
          child: ListAnimator(
            customPadding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
            data: List.generate(
                8,
                (index) => SuggestionCard(
                      suggestionItem: SuggestionItem(name: "Suggestion Item"),
                    )),
          ),
        );
      },
    );
  }
}
