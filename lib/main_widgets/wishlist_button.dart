import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:stepOut/main_blocs/user_bloc.dart';
import '../../../components/custom_images.dart';
import '../app/core/app_core.dart';
import '../app/core/app_event.dart';
import '../app/core/svg_images.dart';
import '../data/config/di.dart';
import '../main_models/items_model.dart';

class WishlistButton extends StatelessWidget {
  final ItemModel? item;

  const WishlistButton({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistBloc, AppState>(
      builder: (context, state) {
        bool isFav = false;

        if (state is Done) {
          List<ItemModel> items = (state.model as ItemsModel).data ?? [];
          isFav = items
                  .map((e) => e.id)
                  .toList()
                  .indexWhere((e) => e == item?.id) !=
              -1;
        }
        return customContainerSvgIcon(
            onTap: () {
              if (UserBloc.instance.isLogin) {
                sl<WishlistBloc>().add(Update(arguments: {
                  "isFav": isFav,
                  "item": item,
                }));
              } else {
                AppCore.showToast(getTranslated("login_first"));
              }
            },
            width: 40,
            height: 40,
            radius: 100,
            padding: 10,
            backGround: Colors.black.withOpacity(0.1),
            imageName: isFav ? SvgImages.fillFav : SvgImages.favorite);
      },
    );
  }
}
