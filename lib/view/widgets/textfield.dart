import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextForm extends StatelessWidget {
  TextEditingController? controller;
  String label;
  Widget? icon;
  String hint;
  TextInputAction textAction;
  bool obscure;
  TextInputType inputType;
  Widget? suffixicon;
  String? Function(String?)? validator;

  TextForm(
      {super.key,
      this.controller,
      required this.hint,
      this.icon,
      required this.inputType,
      required this.label,
      required this.obscure,
      this.suffixicon,
      required this.textAction,
      this.validator,
    
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        icon: icon,
        suffixIcon: suffixicon,
      ),
      textInputAction: textAction,
      obscureText: obscure,
      keyboardType: inputType,
      validator: validator,
    );
  }
}
