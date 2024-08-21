import 'package:educode/controllers/avatar_controller.dart';
import 'package:educode/interfaces/widgets/avatars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircleAvatarCustom extends StatelessWidget {
  CircleAvatarCustom({super.key});

  final List<String> _avatars = [
    "https://cdn.hobbyconsolas.com/sites/navi.axelspringer.es/public/media/image/2017/05/WonderWoman_curiosidades_header.jpg?tf=1200x900",
    "https://cdn.marvel.com/content/1x/scarlet_witch_2024_1_cover_crop.jpg",
    "https://avatarfiles.alphacoders.com/115/115438.jpg",
    "https://lh5.googleusercontent.com/proxy/AbrDsHTgTK7Iksm3avPIo9khthrZVgpKYjaXFt4bFG3vhrrG1FAncHOMViVUtjlzpfr6xLePME5iW9zS_142BqdgpbEq0H7q5yTUaq-Hdmy6VpCCnG3thZ7UirtSYCouXWL13ewN",
    "https://i.pinimg.com/736x/04/88/cf/0488cf690fc02dfde19829076474739f.jpg",
    "https://avatarfiles.alphacoders.com/191/191627.jpg",
  ];

  final avatar = Get.put<AvatarController>(AvatarController());

  @override
  Widget build(BuildContext context) {
    PickAvatar pick = PickAvatar(_avatars);

    return Obx(() {
      return CircleAvatar(
        backgroundImage: NetworkImage(avatar.avatar.value),
        radius: 60,
        backgroundColor: Colors.white,
        child: Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            onPressed: () {
              pick.showAvatarDialog(context);
            },
            icon: Icon(Icons.add_circle_outline, size: 30, color: Color(0xFFFF5F6D)),
          ),
        ),
      );
    });
  }
}