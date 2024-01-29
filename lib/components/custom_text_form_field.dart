import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stepOut/app/core/dimensions.dart';
import 'package:stepOut/app/core/extensions.dart';
import 'package:stepOut/app/core/text_styles.dart';
import '../app/core/styles.dart';
import '../app/core/svg_images.dart';
import 'custom_images.dart';

class CustomTextField extends StatefulWidget {
  final IconData? suffixIcon;
  final TextInputAction keyboardAction;
  final Color? iconColor;
  final TextInputType? inputType;
  final String? hint;
  final String? label;
  final double labelSpace;
  final void Function(String)? onChanged;
  final bool isPassword;
  final void Function(String)? onSubmit;
  final FocusNode? focusNode, nextFocus;
  final FormFieldValidator<String>? validate;
  final int? maxLines;
  final int? minLines;
  final TextEditingController? controller;
  final bool keyboardPadding;
  final bool withLabel;
  final bool readOnly;
  final int? maxLength;
  final bool obscureText;
  final bool? autoFocus;
  final bool? alignLabel;
  final String? errorText;
  final String? initialValue;
  final bool isEnabled;
  final bool? alignLabelWithHint;
  final Widget? prefixIcon;
  final bool? withPadding;
  final Widget? suffixWidget;
  final GestureTapCallback? onTap;
  final Color? onlyBorderColor;
  final List<TextInputFormatter>? formattedType;
  final Alignment? align;
  final Function(dynamic)? onTapOutside;
  final double? height;

  const CustomTextField({
    Key? key,
    this.height,
    this.suffixIcon,
    this.keyboardAction = TextInputAction.next,
    this.align,
    this.inputType,
    this.hint,
    this.alignLabelWithHint = false,
    this.onChanged,
    this.validate,
    this.obscureText = false,
    this.isPassword = false,
    this.readOnly = false,
    this.labelSpace = 8,
    this.maxLines = 1,
    this.minLines = 1,
    this.isEnabled = true,
    this.withPadding = true,
    this.alignLabel = false,
    this.controller,
    this.errorText = "",
    this.maxLength,
    this.formattedType,
    this.focusNode,
    this.nextFocus,
    this.iconColor,
    this.keyboardPadding = false,
    this.autoFocus,
    this.initialValue,
    this.onSubmit,
    this.prefixIcon,
    this.onlyBorderColor,
    this.suffixWidget,
    this.withLabel = true,
    this.label,
    this.onTap,
    this.onTapOutside,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final InputBorder _borders = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(
      style: BorderStyle.solid,
      color: Styles.HINT_COLOR,
      width: 1,
    ),
  );

  bool _isHidden = true;
  void _visibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.withLabel)
            Text(
              widget.label ?? "",
              style: AppTextStyles.semiBold.copyWith(
                color: Styles.PRIMARY_COLOR,
                fontSize: 14,
              ),
            ),
          if (widget.withLabel) SizedBox(height: widget.labelSpace),
          TextFormField(
            focusNode: widget.focusNode,
            initialValue: widget.initialValue,
            textInputAction: widget.keyboardAction,
            textAlignVertical: widget.inputType == TextInputType.phone
                ? TextAlignVertical.center
                : TextAlignVertical.top,
            onTap: widget.onTap,
            autofocus: widget.autoFocus ?? false,
            maxLength: widget.maxLength,
            onFieldSubmitted: (v) {
              widget.onSubmit?.call(v);
              FocusScope.of(context).requestFocus(widget.nextFocus);
            },
            readOnly: widget.readOnly,
            obscureText:
                widget.isPassword == true ? _isHidden : widget.obscureText,
            controller: widget.controller,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            validator: widget.validate,
            keyboardType: widget.inputType,
            onChanged: widget.onChanged,
            inputFormatters: widget.inputType == TextInputType.phone
                ? [FilteringTextInputFormatter.allow(RegExp('[0-9]'))]
                : widget.formattedType ?? [],
            onTapOutside: (v) {
              widget.onTapOutside?.call(v);
              FocusManager.instance.primaryFocus?.unfocus();
            },
            style: AppTextStyles.medium.copyWith(
              fontSize: 14,
              overflow: TextOverflow.ellipsis,
              color: Styles.HEADER,
            ),
            scrollPhysics: const BouncingScrollPhysics(),
            scrollPadding: EdgeInsets.only(
                bottom: widget.keyboardPadding ? context.bottom : 0.0),
            decoration: InputDecoration(
              enabled: widget.isEnabled,
              // labelText: widget.label,
              hintText: widget.hint ?? '',
              alignLabelWithHint:
                  widget.alignLabelWithHint ?? widget.alignLabel,
              disabledBorder: _borders.copyWith(
                  borderSide: const BorderSide(
                width: 1,
                color: Styles.DISABLED,
              )),
              focusedBorder: _borders.copyWith(
                  borderSide: const BorderSide(
                width: 1,
                color: Styles.PRIMARY_COLOR,
              )),
              errorBorder: _borders.copyWith(
                  borderSide: const BorderSide(
                width: 1,
                color: Styles.ERORR_COLOR,
              )),
              enabledBorder: _borders,
              border: _borders,
              fillColor: Styles.FILL_COLOR,
              errorMaxLines: 2,
              errorText: widget.errorText,
              errorStyle: AppTextStyles.semiBold.copyWith(
                color: Styles.ERORR_COLOR,
                fontSize: 14,
              ),
              labelStyle: const TextStyle(
                  color: Styles.PRIMARY_COLOR,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
              floatingLabelStyle: const TextStyle(
                  color: Styles.PRIMARY_COLOR,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintStyle: AppTextStyles.medium.copyWith(
                color: Styles.HINT_COLOR,
                fontSize: 12.0,
              ),
              suffixIcon: widget.isPassword == true
                  ? IconButton(
                      padding: EdgeInsets.symmetric(
                        horizontal: widget.withPadding! ? 16.w : 0,
                      ),
                      onPressed: _visibility,
                      alignment: Alignment.center,
                      icon: _isHidden
                          ? customImageIconSVG(
                              imageName: SvgImages.hiddenEyeIcon,
                              height: 16.55.h,
                              width: 19.59.w,
                              color: const Color(0xFF8B97A3),
                            )
                          : customImageIconSVG(
                              imageName: SvgImages.eyeIcon,
                              height: 16.55.h,
                              width: 19.59.w,
                              color: Styles.PRIMARY_COLOR,
                            ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: widget.withPadding! ? 16.w : 0,
                      ),
                      child: widget.suffixIcon != null
                          ? Icon(
                              widget.suffixIcon,
                              size: 20,
                              color: widget.iconColor ?? Colors.grey[400],
                            )
                          : widget.suffixWidget),
              prefixIcon: widget.withPadding!
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: widget.withPadding! ? 16.w : 0,
                      ),
                      child: widget.prefixIcon,
                    )
                  : widget.prefixIcon,
              prefixIconConstraints: BoxConstraints(maxHeight: 25.h),
              suffixIconConstraints: BoxConstraints(maxHeight: 25.h),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
            ),
          ),
        ],
      ),
    );
  }
}
