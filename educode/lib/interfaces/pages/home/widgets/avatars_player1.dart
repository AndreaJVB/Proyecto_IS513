import 'package:educode/controllers/avatar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CircleAvatarCustomPlayer1 extends StatelessWidget {
  CircleAvatarCustomPlayer1({super.key});

  final List<String> _avatars = [
    "https://cdn.hobbyconsolas.com/sites/navi.axelspringer.es/public/media/image/2017/05/WonderWoman_curiosidades_header.jpg?tf=1200x900",
    "https://cdn.marvel.com/content/1x/scarlet_witch_2024_1_cover_crop.jpg",
    "https://avatarfiles.alphacoders.com/115/115438.jpg",
    "https://lh5.googleusercontent.com/proxy/AbrDsHTgTK7Iksm3avPIo9khthrZVgpKYjaXFt4bFG3vhrrG1FAncHOMViVUtjlzpfr6xLePME5iW9zS_142BqdgpbEq0H7q5yTUaq-Hdmy6VpCCnG3thZ7UirtSYCouXWL13ewN",
    "https://i.pinimg.com/736x/04/88/cf/0488cf690fc02dfde19829076474739f.jpg",
    "https://avatarfiles.alphacoders.com/191/191627.jpg",
  ];

  final avatar = Get.find<AvatarController>();

  @override
  Widget build(BuildContext context) {
    PickAvatarPlayer1 pick = PickAvatarPlayer1(_avatars);

    return Obx(() {
      return CircleAvatar(
        backgroundImage: NetworkImage(avatar.avatarPlayer1.value),
        radius: 60,
        backgroundColor: Colors.white,
        child: Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            onPressed: () {
              pick.showAvatarDialog(context);
            },
            icon: Icon(Icons.add_circle_outline, size: 30, color: Colors.white),
          ),
        ),
      );
    });
  }
}

///ESCOGER AVATAR
class PickAvatarPlayer1 {
  PickAvatarPlayer1(this.avatars);
  final List<String> avatars;
  final avatar = Get.find<AvatarController>();

  void showAvatarDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return Align(
          alignment: Alignment.center,
          child: Material(
            color: Colors.transparent,
            child: FadeTransition(
              opacity: animation,
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  height: 300.0,
                  width: 300.0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Elige un avatar',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20.0),
                      Expanded(
                        child: GridView.builder(
                          padding: EdgeInsets.all(8),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemCount: avatars.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                avatar.avatarPlayer1.value = avatars[index];
                                Navigator.of(context).pop(); 
                              },
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(avatars[index]),
                                radius: 30,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 300),
      barrierDismissible: true,
      barrierLabel: '',
    );
  }
}