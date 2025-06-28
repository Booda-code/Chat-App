import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
   CustomTextButton({super.key,required this.text,this.onPressed});
String text;
   void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        fixedSize: Size(MediaQuery.of(context).size.width, 25),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }
}
