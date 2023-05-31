
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{

  static void focusNode(BuildContext context,FocusNode currentNode, FocusNode nextFocus){
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static showMessage(String message){
    Fluttertoast.showToast(msg: message);
  }

  static void flushBarErrorMessage(String message, BuildContext context){
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          padding: const EdgeInsets.all(15),
          message: message,
          duration: const Duration(seconds: 2),
          borderRadius: BorderRadius.circular(10.0),
          reverseAnimationCurve: Curves.easeOut,
          positionOffset: 20,
          flushbarPosition: FlushbarPosition.TOP,
          icon: const Icon(Icons.error,size: 28,color: Colors.white,),
        )..show(context)
    );
  }

  static snakeBar(String message, BuildContext context){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(message),
        backgroundColor: Colors.blue,

      )
    );
  }

}