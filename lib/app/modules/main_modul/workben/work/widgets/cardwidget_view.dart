/// 自定义卡片组件

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../component/common/screen_adapter.dart';
import '../controllers/work_controller.dart';
import 'app_group_widget_view.dart';
import 'big_title_widget_view.dart';

class CardwidgetView extends GetView<WorkController> {
  final List showList;
  final String titleText;
  final Widget tabbarWidget;
  final Widget tabbarView;
  final bool isShowTab;
  const CardwidgetView({
    Key? key,
    required this.showList,
    required this.titleText,
    required this.tabbarWidget,
    required this.tabbarView,
    this.isShowTab = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(
            ScreenAdapter.width(20), 0, ScreenAdapter.width(20), 0),
        child: Card(
          color: Colors.white,
          //shape 设置边，可以设置圆角
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          // clipBehavior: Clip.antiAlias, // 设置抗锯齿
          elevation: 0.0, // 设置阴影大小
          child: Column(children: [
            // 标题
            Row(
              children: [
                BigTitleWidgetView(
                  title: titleText,
                  // isShowTip: true,
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      controller.navigateAndRefresh(context, showList);
                    },
                    icon: Icon(
                      Icons.more_horiz,
                      color: Colors.black.withOpacity(0.6),
                    ))
              ],
            ),
            // 是否是常用应用
            Offstage(
              offstage: isShowTab,
              child: AppGroupWidgetView(
                listData: showList,
                onTapItemCallBack: (index) {
                  // String title = showList[index]["name"];
                  controller.getFormConfigOfId(showList[index]["id"], context);
                },
              ),
            ),
            // 是否显示tabbar
            Offstage(offstage: !isShowTab, child: tabbarWidget),
            // tabbarView是否显示
            Offstage(
              offstage: !isShowTab,
              child: tabbarView,
            ),
          ]),
        ));
  }
}
