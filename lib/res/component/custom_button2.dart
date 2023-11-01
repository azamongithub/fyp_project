import 'package:flutter/material.dart';

class CustomButtonTwo extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color color, textColor;
  final bool loading;

  const CustomButtonTwo(
      {Key? key,
        required this.title,
        required this.onTap,
        this.loading = false,
        this.color = Colors.black,
        this.textColor = Colors.black, required Widget child,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading? null : onTap,
      child: Container(
        height: 50,
        width: 400,
        decoration: BoxDecoration(
          color: const Color(0xff3140b0),
          borderRadius: BorderRadius.circular(50),

        ),
        child: Center(
          child: loading
              ? const Center(child: CircularProgressIndicator(strokeWidth: 3 , color: Colors.white))
              : Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
