import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../../component/common/no_scroll_behavior.dart';
import '../../../../../component/common_widgets/common_navi_widget.dart';
import '../controllers/work_controller.dart';
import 'work_view.dart';

class WorkPageView extends GetView<WorkController> {
  const WorkPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // controller.checkout();
    controller.checkIfLoggedIn(); // 刷新待办数量
    //这里数据源没有变化就不必再重现创建
    return Scaffold(
      body: _buildContent(),
      appBar: commonAppNaviBar(context, '工作台', 0, false,
          rightWidget: IconButton(
              onPressed: () {
                controller.backAndRefreshNotice(
                    context, '/notice-list-page', null);
              },
              icon: Image.asset(
                'imgs/common/notice.png',
                width: 28,
              ))),
    );
  }

  Widget _buildContent() {
    return ScrollConfiguration(
        behavior: NoScrollBehavior(),
        child: GetBuilder<WorkController>(builder: (controller) {
          return WorkView(
            cylistData: controller.applyForms,
          );
        }));
  }
}
