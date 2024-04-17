import 'package:elwekala_ecommerce_app/consts/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Button extends StatelessWidget {
  VoidCallback onpressed;
  String text;
  double? width;
  double? height;

  Button({
    super.key,
    required this.onpressed,
    required this.text,
   this.height,
   this.width
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width:  width ?? 150.0,
      height:height ?? 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: ElevatedButton(
          onPressed: onpressed,
          style: ElevatedButton.styleFrom(
           backgroundColor:lightpurple, 
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
          )),
    );
  }
}
