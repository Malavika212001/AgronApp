import 'package:flutter/material.dart';

class UserTile extends StatefulWidget {
  const UserTile({super.key, required this.text, this.onTap, required this.text1});

  final String text;
  final String text1;
  final void Function()? onTap;

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(vertical:5, horizontal: 25),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(Icons.person),
            SizedBox(width: 10,),
            Text(widget.text),
            SizedBox(width: 10,),
            Text(widget.text1),
          ],),
      ),
    );
  }
}