import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Route materialPageRoute(Widget page) => MaterialPageRoute(builder: (context) => page);
Route cupertinoPageRoute(Widget page) => CupertinoPageRoute(builder: (context) => page);
Route pageRoute(Widget page) => Platform.isAndroid ? materialPageRoute(page) : cupertinoPageRoute(page);
void push(BuildContext context, Widget page){
  Navigator.push(context, pageRoute(page));
}
void pushAndRemoveUntil(BuildContext context, Widget page){
  Navigator.pushAndRemoveUntil(context, pageRoute(page), (route) => false);
}
void pop(BuildContext context, [Object? object]){
  Navigator.pop(context, object);
}