import 'package:get/get.dart';

import '../controllers/notice_list_page_controller.dart';

class NoticeListPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoticeListPageController>(
      () => NoticeListPageController(),
    );
  }
}
