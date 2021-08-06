import 'package:get/get.dart';

class MainAdminController extends GetxController {
  final indexSelect = 0.obs;

  @override
  void onReady() {
    super.onReady();
  }

  changeSelectIndex(int index)
  {
    indexSelect.value = index;
  }
}