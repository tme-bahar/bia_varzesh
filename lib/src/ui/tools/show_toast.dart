import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToastModel( String message,Color backCol,Color textCol,Toast delay){
  Fluttertoast.showToast(
      msg: "$message",
      toastLength: delay,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: backCol,
      textColor: textCol,
      fontSize: 16.0
  );
}
