import 'package:get/get.dart';

import '../controllers/notice_detail_page_controller.dart';

class NoticeDetailPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoticeDetailPageController>(
      () => NoticeDetailPageController(),
    );
  }
}
