import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepOut/app/core/app_state.dart';
import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:stepOut/main_blocs/user_bloc.dart';
import '../../../components/custom_images.dart';
import '../app/core/app_core.dart';
import '../app/core/svg_images.dart';
import '../main_models/items_model.dart';

class WishlistButton extends StatelessWidget {
  final int? id;

  const WishlistButton({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistBloc, AppState>(
      builder: (context, state) {
        bool isFav = false;

        if (state is Done) {
          List<ItemModel> items = (state.model as ItemsModel).data ?? [];
          isFav =
              items.map((e) => e.id).toList().indexWhere((e) => e == id) != -1;
        }

        return InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            radius: 10,
            onTap: () {
              if (UserBloc.instance.isLogin) {
                // provider.updateFavourites(id: id!, isExist: isFav);
              } else {
                AppCore.showToast(getTranslated("login_first"));
              }
            },
            child: customImageIconSVG(
                imageName:
                    isFav ? SvgImages.favourite : SvgImages.disFavourite));
      },
    );
  }
}
