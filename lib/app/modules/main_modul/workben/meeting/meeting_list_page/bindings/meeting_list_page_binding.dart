import 'package:get/get.dart';

import '../controllers/meeting_list_page_controller.dart';

class MeetingListPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MeetingListPageController>(
      () => MeetingListPageController(),
    );
  }
}
