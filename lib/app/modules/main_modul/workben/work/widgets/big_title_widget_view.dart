/// 大标题组件

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../../../component/common/color_untils.dart';
import '../../../../../component/common/screen_adapter.dart';
import '../../../../../component/common_widgets/gap.dart';

class BigTitleWidgetView extends GetView {
  final String title;
  final double fontSize;
  final double paddingLeft;
  final bool isShowTip;
  const BigTitleWidgetView({
    Key? key,
    required this.title,
    this.fontSize = 32,
    this.paddingLeft = 20,
    this.isShowTip = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blue,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: ScreenAdapter.width(paddingLeft)),
      child: Row(
        children: [
          Offstage(
            offstage: !isShowTip,
            child: Container(
              color: ColorUtils.appMain,
              width: ScreenAdapter.width(8),
              height: ScreenAdapter.height(28),
            ),
          ),
          Gap.w5,
          Text(
            title,
            style: TextStyle(
              fontSize: ScreenAdapter.fontSize(fontSize),
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
