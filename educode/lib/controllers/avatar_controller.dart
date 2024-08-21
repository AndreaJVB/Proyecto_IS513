import 'package:get/get.dart';

class AvatarController extends GetxController {
    final RxString avatar = ''.obs;
    final RxString avatarPlayer1 = "https://cdn.hobbyconsolas.com/sites/navi.axelspringer.es/public/media/image/2017/05/WonderWoman_curiosidades_header.jpg?tf=1200x900".obs;
    final RxString avatarPlayer2 = "https://lh5.googleusercontent.com/proxy/AbrDsHTgTK7Iksm3avPIo9khthrZVgpKYjaXFt4bFG3vhrrG1FAncHOMViVUtjlzpfr6xLePME5iW9zS_142BqdgpbEq0H7q5yTUaq-Hdmy6VpCCnG3thZ7UirtSYCouXWL13ewN".obs;

     @override
  void onInit() {
    super.onInit();
    //hacer mas cosas
    //validar si tiene sesión activa
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
}