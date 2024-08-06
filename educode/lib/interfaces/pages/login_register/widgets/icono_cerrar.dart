import 'package:flutter/material.dart';
import 'package:get/get.dart';

class closeIcon extends StatelessWidget {
  const closeIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40, 
      left: 20, 
      child: IconButton(
        icon: const Icon(Icons.close,size: 25,),
        onPressed: () {
          Get.back(); 
        },
        color: const Color.fromARGB(255, 255, 253, 253),
      ),
    );
  }
}