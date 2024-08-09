import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:worker/core/extensions/context_extensions.dart';
import 'package:worker/core/extensions/widget_extensions.dart';

class MainTextField extends StatefulWidget {
  const MainTextField({
    super.key,
    this.hintTextStyle,
    this.borderColor,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.isPassword = false,
    this.enabled = true,
    this.autoFocus = false,
    this.error = false,
    this.smallSuffixIcon = false,
    this.borderRadius,
    this.maxLines = 1,
    this.hintColor,
    this.width,
    this.height,
    this.label,
    this.fillColor,
    this.hint,
    this.onSubmitted,
    this.controller,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.contentPadding,
    this.textAlign = TextAlign.start,
    this.hasDropDown = false,
    this.hintSize,
    this.readOnly = false,
    this.text,
    this.hasPoint = false,
  });

  final bool? hasDropDown;
  final String? text;
  final TextInputAction textInputAction;
  final Color? borderColor;
  final double? width;
  final Function(String)? onSubmitted;
  final double? height;
  final String? hint;
  final Color? hintColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool enabled, readOnly;
  final bool autoFocus;
  final bool smallSuffixIcon;
  final bool error;
  final int maxLines;
  final BorderRadius? borderRadius;
  final Color? fillColor;
  final Function(String)? onChanged;
  final String? label;
  final AutovalidateMode? autovalidateMode;
  final EdgeInsetsGeometry? contentPadding;
  final TextAlign textAlign;
  final TextStyle? hintTextStyle;
  final double? hintSize;
  final bool hasPoint;

  @override
  State<MainTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField>
    with WidgetsBindingObserver {
  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addObserver(this);
    super.didChangeDependencies();
  }

  final ValueNotifier<bool> _obscure = ValueNotifier(false);

  @override
  void initState() {
    _obscure.value = widget.isPassword;
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  String cc = '1';

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (widget.text != null)
        Text(widget.text!,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold)),
      if (widget.text != null) 7.verticalSpace,
      ValueListenableBuilder(
          valueListenable: _obscure,
          builder: (context, obsecureValue, _) {
            return TextFormField(
              style: context.textTheme.headlineLarge
                  ?.copyWith(fontWeight: FontWeight.w400, fontSize: 12),
              controller: widget.controller,
              validator: widget.validator,
              onFieldSubmitted: widget.onSubmitted,
              textInputAction: widget.textInputAction,
              cursorColor: widget.borderColor ?? context.primaryColor,
              enabled: widget.enabled,
              readOnly: widget.readOnly,
              inputFormatters: widget.keyboardType == TextInputType.number
                  ? !widget.hasPoint
                      ? [FilteringTextInputFormatter.digitsOnly]
                      : [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}')),
                        ]
                  : null,
              keyboardType: widget.keyboardType,
              maxLines: widget.maxLines,
              onChanged: widget.onChanged,
              autofocus: widget.autoFocus,
              obscureText: widget.isPassword && obsecureValue,
              enableSuggestions: widget.isPassword,
              autocorrect: widget.isPassword,
              autovalidateMode: widget.autovalidateMode,
              textAlign: widget.textAlign,
              onTap: () {
                if (widget.controller != null &&
                    widget.controller!.text.isEmpty) {
                  final lastSelectionPosition = TextSelection.fromPosition(
                    TextPosition(offset: widget.controller!.text.length - 1),
                  );

                  final afterLastSelectionPosition = TextSelection.fromPosition(
                    TextPosition(offset: widget.controller!.text.length),
                  );

                  if (widget.controller!.selection == lastSelectionPosition) {
                    widget.controller!.selection = afterLastSelectionPosition;
                  }
                }
              },
              decoration: InputDecoration(
                contentPadding: widget.contentPadding,
                floatingLabelBehavior:
                    !widget.enabled ? FloatingLabelBehavior.always : null,
                label: widget.label == null ? null : Text(widget.label!),
                filled: true,
                hintText: widget.hint,
                labelStyle:
                    widget.hintTextStyle ?? context.textTheme.bodyMedium,
                fillColor:
                    widget.fillColor ?? context.theme.scaffoldBackgroundColor,
                focusColor: context.theme.primaryColor,
                hintStyle: widget.hintTextStyle ??
                    context.textTheme.bodyMedium!.copyWith(
                        color: context.theme.hintColor,
                        fontWeight: FontWeight.w400,
                        fontSize: widget.hintSize ?? 12),

                enabledBorder: OutlineInputBorder(
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
                  borderSide: BorderSide(color: context.theme.hintColor),
                ),
                errorStyle: context.textTheme.bodySmall
                    ?.copyWith(color: context.theme.colorScheme.error),
                disabledBorder: OutlineInputBorder(
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: widget.error
                        ? context.theme.colorScheme.error
                        : context.theme.hintColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: widget.borderColor ?? context.theme.primaryColor),
                ),
                constraints: BoxConstraints(
                    maxHeight: widget.height ?? double.infinity,
                    maxWidth: widget.width ?? double.infinity),
                border: OutlineInputBorder(
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
                  borderSide: BorderSide(color: context.theme.hintColor),
                ),

                prefixIcon: widget.prefixIcon,
                prefixIconConstraints: widget.smallSuffixIcon
                    ? BoxConstraints(maxWidth: .15.sw)
                    : null,

                suffixIcon: widget.isPassword
                    ? AnimatedSwitcher(
                        duration: Durations.medium2,
                        child: obsecureValue
                            ? Icon(
                                Icons.visibility,
                                size: 15.sp,
                              ).onTap(() {
                                _obscure.value = !obsecureValue;
                              })
                            : SvgPicture.asset(
                                'assets/icons/hide_password.svg',
                                width: 15.sp,
                                height: 15.sp,
                                fit: BoxFit.scaleDown,
                              ).onTap(() {
                                _obscure.value = !obsecureValue;
                              }),
                      )
                    : widget.suffixIcon,
                suffixIconConstraints: widget.smallSuffixIcon
                    ? BoxConstraints(maxWidth: .15.sw)
                    : null,
                // contentPadding: widget.maxLines != 1 ? null : const EdgeInsets.symmetric(horizontal: 16.0),
              ),
            );
          }),
    ]);
  }
}
