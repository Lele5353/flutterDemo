import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../component/common/color_untils.dart';
import '../../../../../../component/common/screen_adapter.dart';
import '../../../../../../component/common_widgets/common_navi_widget.dart';
import '../../../../../../component/common_widgets/gap.dart';
import '../../../../address_book/search_page/views/standard_home_search.dart';
import '../controllers/meeting_select_person_controller.dart';
import 'meeting_refresh_list_view.dart';

class MeetingSelectPersonView extends GetView<MeetingSelectPersonController> {
  const MeetingSelectPersonView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.line,
      appBar: commonAppNaviBar(context, '请选择', 1, true, backCallBack: () {
        Get.back(result: controller.selectedPerson);
      }, rightWidget:
          GetBuilder<MeetingSelectPersonController>(builder: (controller) {
        return Visibility(
            visible: controller.multiple,
            child: ElevatedButton(
                onPressed: () {
                  Get.back(result: controller.selectedPerson);
                },
                child: Text('确定(${controller.selectedPerson.length})')));
      })),
      body: WillPopScope(
          child: _buildCoumnWidget(context),
          onWillPop: () async {
            Get.back(result: controller.selectedPerson);
            return false;
          }),
    );
  }

  Widget _buildCoumnWidget(context) {
    return Column(
      children: [
        // 搜索框
        GetBuilder<MeetingSelectPersonController>(builder: (controller) {
          return Visibility(
              visible: controller.isSearch,
              child: StandardHomeSearch(
                key: ValueKey(controller.valueKey),
                url: controller.url,
                hintText: "搜索",
                onPressed: (item) {
                  if (item.isNotEmpty) {
                    controller.addSearchDataToHome(item);
                  }
                },
              ));
        }),
        GetBuilder<MeetingSelectPersonController>(builder: (controller) {
          return Offstage(
            offstage: controller.selectedPerson.isEmpty,
            child: _buildSelectedPersonWidget(controller),
          );
        }),
        // 人员列表
        const Expanded(child: MeetingRefreshListView()),
      ],
    );
  }

// 显示已选择的人员列表，横排
  Widget _buildSelectedPersonWidget(MeetingSelectPersonController controller) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: ScreenAdapter.height(5)),
      padding: EdgeInsets.only(left: ScreenAdapter.height(20)),
      height: ScreenAdapter.height(100),
      child: Row(
        children: [
          Expanded(
              child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) => InkWell(
                onTap: () {
                  // 点击移除
                  controller.removePerson(controller.selectedPerson[index]);
                },
                child: _selectBtnToggleWidget(
                    controller.selectedPerson[index]["name"], index)),
            separatorBuilder: (BuildContext context, int index) => Gap.w10,
            itemCount: controller.selectedPerson.length,
          )),
        ],
      ),
    );
  }

// 被选择的名字toggle
  Widget _selectBtnToggleWidget(name, index) {
    return Chip(
      label: Text(
        name,
        style: TextStyle(
            color: Colors.black.withOpacity(0.6),
            fontSize: ScreenAdapter.fontSize(28)),
      ),
      deleteIconColor: Colors.grey,
      backgroundColor: Colors.grey.withOpacity(0.1),
      onDeleted: () {
        controller.removePerson(controller.selectedPerson[index]);
      },
    );
  }
}
