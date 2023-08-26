import 'package:get/get.dart';

import '../controllers/app_center_page_controller.dart';

class AppCenterPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppCenterPageController>(
      () => AppCenterPageController(),
    );
  }
}
