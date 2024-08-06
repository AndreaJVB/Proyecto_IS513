import 'package:flutter/material.dart';

class CircleAvatarCustom extends StatelessWidget {
  const CircleAvatarCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 60,
      backgroundColor: Colors.white,
      child: Align(
        alignment: Alignment.bottomRight,
        child: IconButton(
          onPressed: () {},
          icon: Icon(Icons.add_circle_outline, size: 30, color: Color(0xFFFF5F6D)),
        ),
      ),
    );
  }
}
