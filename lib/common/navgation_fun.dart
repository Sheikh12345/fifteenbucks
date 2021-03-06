import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future screenPush(BuildContext context, Widget widget)async{
 return Navigator.push(context, MaterialPageRoute(builder: (context)=> widget));
}

screenPushRep(BuildContext context, Widget widget){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> widget));
}

goBackPreviousScreen(BuildContext context){
  Navigator.pop(context);
}