import 'package:get/get.dart';

import '../controllers/meeting_select_person_controller.dart';

class MeetingSelectPersonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MeetingSelectPersonController>(
      () => MeetingSelectPersonController(),
    );
  }
}
