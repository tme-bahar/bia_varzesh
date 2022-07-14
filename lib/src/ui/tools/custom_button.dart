import 'package:bia_varzesh/src/animation/bouncing_line.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';

class CustomButton extends StatelessWidget {
   String text="";
  final VoidCallback? onPress;
  final bool isLoading;
    final TextStyle txtStyle;

   final Color color;
  double borderRadiuse=20.0;
      Icon? icon;

  CustomButton({required this.text,required this.onPress,required this.isLoading,required this.txtStyle,required this.color,required this.icon,required this.borderRadiuse});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return
      RaisedButton(
        onPressed: onPress,
        color: color,
        splashColor: Colors.white,
        shape:(borderRadiuse==null)? RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)):RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiuse)),
        child: isLoading == false
            ?
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
             icon ?? Text(""),
              Text(
                text,
                style: txtStyle,
              )
            ],)

            : /*LoadingBouncingLine.circle(
          backgroundColor: Colors.white,
          duration: Duration(milliseconds: 2400),*/
        Text('data')
      );
  }

}
