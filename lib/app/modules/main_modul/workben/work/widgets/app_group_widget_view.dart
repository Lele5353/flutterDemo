/// 控制台主页显示items的组件
///
/// 默认一行显示四个，每一个item的颜色随机变化

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iconify_flutter/icons/ep.dart';

import '../../../../../component/common/screen_adapter.dart';
import '../controllers/work_controller.dart';
import 'grid_item_widget.dart';

typedef OnTapItemCallBack = void Function(int index);

class AppGroupWidgetView extends GetView<WorkController> {
  final List listData;
  final int mainCount; // 一行几个
  final double itemH;
  final bool isSvg;
  final OnTapItemCallBack onTapItemCallBack;
  const AppGroupWidgetView({
    Key? key,
    required this.listData,
    required this.onTapItemCallBack,
    this.mainCount = 4, // 默认是四个
    this.itemH = 50, // 默认item大小
    this.isSvg = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      MasonryGridView.count(
          padding: EdgeInsets.only(
              top: ScreenAdapter.height(20), bottom: ScreenAdapter.height(30)),
          crossAxisCount: mainCount,
          mainAxisSpacing: ScreenAdapter.width(40), //行间距
          itemCount: listData.length, //注意
          shrinkWrap: true, //收缩，让元素宽度自适应
          physics: const NeverScrollableScrollPhysics(), //禁止滑动）
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  onTapItemCallBack(index);
                },
                child: Column(
                  children: [
                    GridItemWidget(
                        bgColor: Colors.white,
                        image: listData[index]["icon"] ?? Ep.menu,
                        itemH: itemH,
                        isSvg: isSvg,
                        isMore: false),
                    Container(
                      margin: EdgeInsets.only(top: ScreenAdapter.height(8)),
                      child: Text(
                        listData[index]["name"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: ScreenAdapter.fontSize(24),
                        ),
                      ),
                    ),
                  ],
                ));
          })
    ]);
  }
}
