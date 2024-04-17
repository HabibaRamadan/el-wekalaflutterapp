import 'package:flutter/material.dart';

Future navigateTo(context, Widget page, {dynamic argu,bool root= false }) {
  return Navigator.of(context,rootNavigator:root).push( MaterialPageRoute(
    builder: (context) => page,
    settings: RouteSettings(arguments:argu )
    
    ));
}
