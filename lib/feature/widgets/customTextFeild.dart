import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';
import 'main_text.dart';

class CustomTextField extends StatefulWidget {
  final String? hint;
  final int? minLines;
  final int? maxLines;
  final bool? hasLabel;
  final Color? hintColor;
  final int? maxLength;
  final bool nullMax;
  final TextInputType? type;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String?)? onsave;
  final Function(String?)? onChange;
  final Function()? iconCallback;
  final String? Function(String?)? valid;
  final AutovalidateMode? validationMode;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color? headerTextColor;
  final bool isPassword;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final FocusNode? focus;
  final bool autoFocus;
  final bool? read;
  final bool withPasswordIcon;
  final bool isPhone;
  final bool? flag;
  final TextAlign? align;
  final TextInputAction? action;
  final VoidCallback? edit;
  final bool? isEdit;
  final double? hor;

  CustomTextField({
    this.hint,
    this.maxLines,
    this.onsave,
    this.onTap,
    this.headerTextColor,
    this.minLines,
    this.hintColor,
    this.withPasswordIcon = true,
    this.suffixIcon,
    this.type,
    this.maxLength,
    this.nullMax = false,
    this.inputFormatters,
    this.fillColor,
    this.valid,
    this.action,
    this.align,
    this.onChange,
    this.isPassword = false,
    this.iconCallback,
    this.controller,
    this.isPhone = false,
    this.focus,
    this.autoFocus = false,
    this.prefixIcon,
    this.hasLabel,
    this.read,
    this.edit,
    this.isEdit,
    this.flag,
    this.hor,
    this.validationMode,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isHidden = true;

  void _visibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      validator: widget.valid,
      controller: widget.controller,
      cursorColor: Colors.grey,
      onSaved: widget.onsave,
      focusNode: widget.focus,
      inputFormatters: widget.inputFormatters,
      textAlign: widget.align ?? TextAlign.start,
      textInputAction: widget.action,
      readOnly: widget.read == true ? true : false,
      maxLines: widget.nullMax ? null : widget.maxLines ?? widget.minLines ?? 1,
      minLines: widget.minLines,
      autofocus: widget.autoFocus,
      maxLength: widget.isPhone ? 11 : widget.maxLength,
      obscureText: widget.isPassword ? _isHidden : false,
      keyboardType: widget.type,
      onChanged: widget.onChange,
      style: TextStyle(
        fontSize: 18.sp,
        color: Colors.black,
        fontFamily: 'IBM',
      ),
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        hintText: widget.hint,
        fillColor: widget.fillColor ?? kAccentColor,
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        prefixIcon: widget.prefixIcon != null
            ? Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: IconButton(
                  icon: widget.prefixIcon!,
                  onPressed: () {},
                ),
              )
            : null,
        labelText: widget.hasLabel == true ? widget.hint : null,
        prefix: widget.flag == true ? const MainText(text: "+966  ") : null,
        icon: widget.isEdit == true ? const Icon(Icons.edit) : null,
        counterText: '',
        labelStyle: TextStyle(
          fontSize: 16.sp,
          color: Colors.black,
          fontFamily: 'IBM',
        ),
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: widget.hintColor ?? Colors.grey,
          fontFamily: 'IBM',
        ),
        suffixIcon: widget.isPassword
            ? widget.withPasswordIcon
                ? Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: IconButton(
                      onPressed: _visibility,
                      alignment: Alignment.center,
                      icon: _isHidden
                          ? const Icon(
                              Icons.visibility_off,
                              color: kBlackColor,
                            )
                          : const Icon(
                              Icons.visibility,
                              color: kBlackColor,
                            ),
                    ),
                  )
                : IconButton(
                    onPressed: () {},
                    icon: Container(),
                  )
            : Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: widget.suffixIcon ??
                    Container(
                      height: 25.h,
                      width: 25.w,
                    ),
              ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kInactiveColor, width: 1.5),
          borderRadius: BorderRadius.circular(20.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kInactiveColor, width: 1.5),
          borderRadius: BorderRadius.circular(20.r),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
    );
  }
}
