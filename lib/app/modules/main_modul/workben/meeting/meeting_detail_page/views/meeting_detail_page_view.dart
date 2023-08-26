// import 'package:avatar_stack/avatar_stack.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../component/common/color_untils.dart';
import '../../../../../../component/common/screen_adapter.dart';
import '../../../../../../component/common_widgets/common_dialog.dart';
import '../../../../../../component/common_widgets/common_navi_widget.dart';
import '../../../../../../component/common_widgets/gap.dart';
import '../../../../mine/mine_flow/mine_approval_descr/views/mine_title_content.dart';
import '../controllers/meeting_detail_page_controller.dart';

class MeetingDetailPageView extends GetView<MeetingDetailPageController> {
  const MeetingDetailPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.scaffoldBgLight,
      appBar: commonAppNaviBar(
        context, '会议详情', 1, true,
        // rightWidget:
        //     GetBuilder<MeetingDetailPageController>(builder: (controller) {
        //   return IconButton(
        //       onPressed: () {
        //         controller.changeStarStatus();
        //       },
        //       icon: Icon(
        //         controller.isStar
        //             ? Icons.star_rounded
        //             : Icons.star_border_rounded,
        //         color: controller.isStar ? Colors.amber : Colors.grey,
        //       ));
        // })
      ),
      body: Container(
          padding: EdgeInsets.all(ScreenAdapter.width(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _centerContent(),
                _buildArrangementCard(context),
              ],
            ),
          )),
    );
  }

  // 详情视图
  Widget _centerContent() {
    return Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        child: Container(
          padding: EdgeInsets.all(ScreenAdapter.width(20)),
          child: SingleChildScrollView(child: _listViewWidget()),
        ));
  }

// 列表页面
  Widget _listViewWidget() {
    return GetBuilder<MeetingDetailPageController>(builder: (controller) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          return MineTitleContent(
            isShowFiles: controller.configList[index]["isHasFiles"],
            files: controller.files,
            title: controller.configList[index]["commonTitle"],
            contentS: controller.configList[index]["commonValue"].toString(),
          );
          // return _itemWithContent(controller.configList[index]["commonTitle"],
          //     controller.configList[index]["commonValue"].toString());
        },
        itemCount: controller.configList.length,
      );
    });
  }

  // 会议决议card
  Widget _buildArrangementCard(context) {
    return Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        child: Container(
          padding: EdgeInsets.all(ScreenAdapter.width(20)),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: ScreenAdapter.screenWidth(),
                color: Colors.white,
                child: Row(
                  children: [
                    Text(
                      '会议决议',
                      style: TextStyle(
                        fontSize: ScreenAdapter.fontSize(32),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    // 新增会议决议
                    IconButton(
                        onPressed: () {
                          controller.getFormConfigWithArrangement(context);
                        },
                        icon: const Icon(
                          Icons.add_box_rounded,
                          color: Colors.blue,
                        ))
                  ],
                ),
              ),
              Gap.lineH1,
              Gap.h5,
              GetBuilder<MeetingDetailPageController>(builder: (controller) {
                return Visibility(
                    visible: controller.meetingarrangementList.isNotEmpty,
                    child: _buildArrangementList(context));
              })
            ],
          )),
        ));
  }

// 会议决议列表
  Widget _buildArrangementList(context) {
    return GetBuilder<MeetingDetailPageController>(builder: (controller) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () {
              Map model = controller.meetingarrangementList[index];
              controller.navigateAndRefresh(context, 'mine-approval-edit', {
                "id": model["id"],
                "itemData": model,
                "isAgain": false,
                "title": "会议安排"
              });
            },
            child: _buildItemWithArrangementWidget(controller, index, context),
          );
        },
        itemCount: controller.meetingarrangementList.length,
      );
    });
  }

  // 会议决议item
  Widget _buildItemWithArrangementWidget(
      MeetingDetailPageController controller, index, context) {
    Map model = controller.meetingarrangementList[index];
    return SizedBox(
      // height: 40,
      child: Row(
        children: [
          Container(
              padding: EdgeInsets.only(right: ScreenAdapter.width(10)),
              child: getMeetingStatus(model["task_state"])),
          Expanded(
            flex: 100,
            child: Text(model["task"]),
          ),
          Gap.w5,
          const Spacer(),
          Chip(
            padding: EdgeInsets.zero,
            side: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
            // shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.all(Radius.circular(5))),
            label: Text(
              '${model["principal"]["choices_key"]}',
              style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: ScreenAdapter.fontSize(26)),
            ),
            // avatar: CircleAvatar(
            //   backgroundImage: NetworkImage(
            //       'https://images.unsplash.com/photo-1458071103673-6a6e4c4a3413?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80'),
            // ),
            // shadowColor: Colors.white,
            backgroundColor: Colors.white,
          ),
          // Gap.w5,
          IconButton(
              onPressed: () {
                // 删除
                CommonDialog.show(context, title: "提示", content: "确认要删除该条记录吗？",
                    onConfirm: () {
                  controller.deleteItemWithId(model["id"]);
                });
              },
              icon: const Icon(
                Icons.delete_outline_rounded,
                color: ColorUtils.grayText,
              ))
        ],
      ),
    );
  }

// 显示会议决议的不用状态
  Widget getMeetingStatus(status) {
    Widget child = const Text("");

    switch (status) {
      case 0:
        {
          child = const Icon(
            Icons.check_box_outline_blank_rounded,
            color: Colors.grey,
            size: 20,
          );
        }
        break;
      case 1:
        {
          child = const Icon(
            Icons.check_box,
            color: Colors.green,
            size: 20,
          );
        }
        break;
      case 2:
        {
          child = const Icon(
            Icons.indeterminate_check_box,
            color: Colors.grey,
            size: 20,
          );
        }
        break;
      default:
    }
    return child;
  }
}
