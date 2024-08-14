import 'package:educode/controllers/avatar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PickAvatar {
  PickAvatar(this.avatars);
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
                                avatar.avatar.value = avatars[index];
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