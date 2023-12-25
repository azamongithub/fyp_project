import 'package:flutter/material.dart';

class DiseaseTextField extends StatelessWidget {
  final TextEditingController? myController;
  final FormFieldValidator? onValidator;
  final String? labelText;
  final int? maxLines;
  final void Function(String)? onChange;

  const DiseaseTextField({
    Key? key,
    this.myController,
    this.labelText,
    this.maxLines,
    this.onValidator,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      validator: onValidator,
      onChanged: onChange,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        labelText: labelText,
      ),
    );
  }
}
