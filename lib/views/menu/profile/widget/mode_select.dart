import 'package:flutter/material.dart';
import 'package:todolistapp/common/commoncolor.dart';

class ModeSelect extends StatelessWidget {
  final IconData? icon;
  final String title;
  final VoidCallback onTap;
  const ModeSelect({
    super.key, 
    this.icon, 
    required this.title, 
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: Commoncolor.black,
      leading: Icon(
        icon,
        size: 20,
        color: Commoncolor.white,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Commoncolor.white,
          fontSize: 14,
          fontWeight: FontWeight.bold
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        size: 15,
        color: Commoncolor.white,
      ),
    );
  }
}