import 'package:flutter/material.dart';
import 'package:flutteroa/app/component/common/color_untils.dart';
import 'package:get/get.dart';

import '../../../../../../component/common/screen_adapter.dart';
import '../../../../../../component/common_widgets/gap.dart';
import '../models/meeting_apply_list_model.dart';

class MeetingItemCardView extends GetView {
  final bool isStar;
  final int currentIndex;
  final MeetingApplyResults item;
  const MeetingItemCardView({
    Key? key,
    this.isStar = false,
    required this.item,
    this.currentIndex = 0,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // String conferees = controller.getConfereeListDataToString(item.conferee);
    return InkWell(
      onTap: () {
        Get.toNamed('/meeting-detail-page',
            arguments: {"index": currentIndex, "itemData": item});
      },
      child: Container(
        padding: EdgeInsets.only(
            left: ScreenAdapter.width(30),
            right: ScreenAdapter.width(20),
            top: ScreenAdapter.height(10)),
        child: Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
            ),
            child: Container(
              padding: EdgeInsets.only(
                  left: ScreenAdapter.width(20),
                  right: ScreenAdapter.width(10),
                  bottom: ScreenAdapter.height(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap.h10,
                  Row(
                    children: [
                      Text(
                        '${item.theme}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: ScreenAdapter.fontSize(34)),
                      ),
                      const Spacer(),
                      Offstage(
                        offstage: isStar,
                        child: const Icon(
                          Icons.star_purple500_sharp,
                          size: 20,
                          color: Colors.amber,
                        ),
                      ),
                      Gap.w10
                    ],
                  ),
                  Gap.height(15),
                  _imgAndText(Icons.access_time, "会议时间: ", "${item.startDate}"),
                  Gap.h5,
                  _imgAndText(Icons.place_outlined, "会议地点: ",
                      "${item.meetingRoom!.name}"),
                  Gap.h5,
                  _imgAndText(Icons.person_2_outlined, "参与人员: ",
                      getConfereeListDataToString(item.conferee!)),
                ],
              ),
            )),
      ),
    );
  }

  Widget _imgAndText(icon, text, content) {
    return Row(
      children: [
        Icon(
          icon,
          color: ColorUtils.hexColor("#8b8e96"),
          size: 18,
        ),
        Gap.w5,
        Text(
          "$text",
          style: TextStyle(
              fontSize: ScreenAdapter.fontSize(28),
              color: ColorUtils.hexColor("#8b8e96")),
        ),
        Expanded(
            child: Text(
          "$content",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: ScreenAdapter.fontSize(28), color: ColorUtils.appMain),
        )),
      ],
    );
  }

  // 获取参会人员
  String getConfereeListDataToString(List conferees) {
    String result = "";
    List names = [];
    for (Conferee item in conferees) {
      names.add(item.name);
    }
    result = names.join(",");
    return result;
  }
}
