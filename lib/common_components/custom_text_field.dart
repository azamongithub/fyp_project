import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController myController;
  final FormFieldValidator onValidator;
  final TextInputType keyBoardType;
  final String? labelText;
  final String? initialValue;
  final int? maxLines;
  final bool autoFocus;
  final FocusNode? focusNode;
  final void Function(String)? onChange;

  const CustomTextField({Key? key,
    required this.myController,
    required this.keyBoardType,
    this.labelText,
    this.maxLines,
    required this.onValidator,
    //this.enable = true,
    this.autoFocus = false,
    this.focusNode,
    this.onChange, this.initialValue,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      validator: onValidator,
      onChanged: onChange,
      keyboardType: keyBoardType,
      autofocus: autoFocus,
      maxLines: maxLines,
      //autofocus: autoFocus,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15)),
        labelText: labelText,

        // hintStyle: TextStyle(
        //   fontSize: 60,
        //   color: Colors.red,
        // ),
      ),
    );
  }
}