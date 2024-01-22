import 'dart:io';
import 'package:flutter/material.dart';
import 'package:stepOut/main_blocs/user_bloc.dart';
import '../app/core/styles.dart';
import '../app/core/svg_images.dart';
import '../components/custom_images.dart';
import '../components/custom_network_image.dart';
import '../components/image_pop_up_viewer.dart';
import '../helpers/image_picker_helper.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget(
      {required this.withEdit,
      this.radius = 68,
      Key? key,
      this.onGet,
      this.imageFile})
      : super(key: key);
  final bool withEdit;
  final Function(File)? onGet;
  final File? imageFile;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (imageFile != null || (UserBloc.instance.user?.image != null)) {
          showDialog(
              context: context,
              barrierColor: Colors.black.withOpacity(0.75),
              builder: (context) {
                return ImagePopUpViewer(
                  image: imageFile != null
                      ? imageFile!
                      : UserBloc.instance.user?.image,
                  isFromInternet: imageFile == null,
                  title: "",
                );
              });
        }
      },
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          imageFile != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.file(
                    imageFile!,
                    height: radius * 2,
                    width: radius * 2,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Center(
                        child: Container(
                            height: radius * 2,
                            width: radius * 2,
                            color: Colors.grey,
                            child: const Center(
                                child:
                                    Icon(Icons.replay, color: Colors.green)))),
                  ),
                )
              : CustomNetworkImage.circleNewWorkImage(
                  color: Styles.HINT_COLOR,
                  image: UserBloc.instance.user?.image ?? "",
                  radius: radius),
          if (withEdit)
            InkWell(
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                if (withEdit) {
                  ImagePickerHelper.showOptionSheet(onGet: onGet);
                }
              },
              child: Container(
                  height: 35,
                  width: 35,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      boxShadow: kElevationToShadow[1],
                      color: Styles.WHITE_COLOR,
                      borderRadius: BorderRadius.circular(100)),
                  child: customImageIconSVG(
                    imageName: SvgImages.cameraIcon,
                  )),
            ),
        ],
      ),
    );
  }
}
