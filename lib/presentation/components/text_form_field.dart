import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    Key? key,
    required this.controller,
    required this.type,
    required this.label,
    required this.prefix,
    required this.validate,
    this.onChange,
    this.onSubmit,
    this.onTap
  }) : super(key: key);
  final TextEditingController controller;
  final TextInputType type;
  final String label;
  final IconData prefix;
  final String? Function(String?) validate;
  void Function(String)? onSubmit;
  void Function(String)? onChange;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      decoration: InputDecoration(
          label: Text(label),
          prefixIcon: Icon(prefix),
          border: const OutlineInputBorder()),
      validator: validate,
      onTap: onTap,
    );
  }
}
