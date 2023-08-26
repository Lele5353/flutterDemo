import 'package:get/get.dart';

import '../controllers/meeting_detail_page_controller.dart';

class MeetingDetailPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MeetingDetailPageController>(
      () => MeetingDetailPageController(),
    );
  }
}
