import 'package:educode/controllers/avatar_controller.dart';
import 'package:educode/interfaces/widgets/avatars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircleAvatarCustom extends StatelessWidget {
  CircleAvatarCustom({super.key});

  final List<String> _avatars = [
    "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQ0RQXx9m_YDPldJAwrV20qqj_wH0D-RttHAuc7_kEbNmc8_tdB",
    "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTCMUGH5BTJ3LfnKSm-8Y6_da6Bv36KgcSVe4Xfzj4Ewq51yeHx",
    "https://i.pinimg.com/564x/81/a2/6d/81a26d74dba12f99b43505dc5665c62b.jpg",
    "https://lh5.googleusercontent.com/proxy/AbrDsHTgTK7Iksm3avPIo9khthrZVgpKYjaXFt4bFG3vhrrG1FAncHOMViVUtjlzpfr6xLePME5iW9zS_142BqdgpbEq0H7q5yTUaq-Hdmy6VpCCnG3thZ7UirtSYCouXWL13ewN",
    "https://forums.pokemmo.com/uploads/monthly_2023_08/00035-447336684.thumb.png.72e5ada7824c6d6ba7e4cd0ca8324cfb.png",
    "https://neural.love/cdn/ai-photostock/1ee3d1b8-472a-62aa-a42a-797064bbce58/1.jpg?Expires=1727740799&Signature=Fq7HqpqY6VK-x8zqLuIau3fm8viQhltuR30sd5x2~M~HJjpelRHyfXcmcJ~CD8GVm-rIClbWAUlATaYsbK5IeIzETT1wTteRg9grd~Eq2Xm9JNsC49o0d2Za2lMbW~vNiXUerksb5mzGxQS~k4vzDWyZ27DS76JR5k-ElifjsTAqYS9gUDEeyYCkgSsmaprAbCSFjZmffjEyN8iJYUv2Cx9SLXlDZ9DCCDyIGyGr6jAJdAkLFbIzJsXofguWlV-Ar4pUSXG9Mm927okYz0pz2wOXnCulkuJY9ZPd72~g5sVVv82ZMFsnGloOmJoLbXrLu-yEB6LZrJ7IzDE6k7Js9Q__&Key-Pair-Id=K2RFTOXRBNSROX",
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