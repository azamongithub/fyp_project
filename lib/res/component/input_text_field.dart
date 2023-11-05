import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController myController;
  final FormFieldValidator onValidator;
  final TextInputType keyBoardType;
  final String labelText;
  final bool autoFocus;
  final FocusNode? focusNode;



  const CustomTextField({Key? key,
    required this.myController,
    required this.keyBoardType,
    required this.labelText,
    required this.onValidator,
    //this.enable = true,
    this.autoFocus = false,
    this.focusNode,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      validator: onValidator,
      keyboardType: keyBoardType,
      autofocus: autoFocus,
      //autofocus: autoFocus,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15)),
        //contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        //hintText: hintText,
        labelText: labelText,

        // hintStyle: TextStyle(
        //   fontSize: 60,
        //   color: Colors.red,
        // ),
      ),



    );
  }
}