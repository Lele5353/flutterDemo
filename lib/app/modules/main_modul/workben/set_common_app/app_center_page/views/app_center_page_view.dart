import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ep.dart';

import '../../../../../../component/common/color_untils.dart';
import '../../../../../../component/common/no_scroll_behavior.dart';
import '../../../../../../component/common/others.dart';
import '../../../../../../component/common/screen_adapter.dart';
import '../../../../../../component/common_widgets/common_dialog.dart';
import '../../../../../../component/common_widgets/common_navi_widget.dart';
import '../../../../../../component/common_widgets/gap.dart';
import '../../../../../../store/iconify_ep.dart';
import '../../../work/widgets/big_title_widget_view.dart';
import '../controllers/app_center_page_controller.dart';

class AppCenterPageView extends GetView<AppCenterPageController> {
  const AppCenterPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: commonAppNaviBar(context, "应用中心", 1, true, backCallBack: () {
          if (controller.isEdit) {
            CommonDialog.show(
              context,
              content: "修改不会保存，是否确认返回吗？",
              onConfirm: () {
                Get.back(result: 'addRef');
              },
            );
          } else {
            Get.back(result: 'addRef');
          }
        },
            rightWidget: TextButton(onPressed: () {
              controller.changeEditStatus();
            }, child:
                GetBuilder<AppCenterPageController>(builder: (controller) {
              return Text(controller.isEdit ? "完成" : "编辑");
            }))),
        body: WillPopScope(
            child: _buildContent(),
            onWillPop: () async {
              if (controller.isEdit) {
                CommonDialog.show(
                  context,
                  content: "修改不会保存，是否确认返回吗？",
                  onConfirm: () {
                    Get.back(result: 'addRef');
                  },
                );
              } else {
                Get.back(result: 'addRef');
              }
              return false;
            }));
  }

  Widget _buildContent() {
    return ScrollConfiguration(
        behavior: NoScrollBehavior(),
        child: GetBuilder<AppCenterPageController>(builder: (controller) {
          return Container(
            color: ColorUtils.scaffoldBgLight,
            child: ListView(
              children: [
                Gap.h10,
                // 常用应用
                _topCommonWidget('常用', controller.commonList, true),
                // 全部应用
                _topCommonWidget('全部', controller.allAppList, false),
                Gap.h10
              ],
            ),
          );
        }));
  }

  // 常用应用
  Widget _topCommonWidget(titleS, listData, isCom) {
    return Container(
        padding: EdgeInsets.fromLTRB(
            ScreenAdapter.width(20),
            ScreenAdapter.height(0),
            ScreenAdapter.width(20),
            ScreenAdapter.height(10)),
        child: Card(
          color: Colors.white,
          //shape 设置边，可以设置圆角
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          // clipBehavior: Clip.antiAlias, // 设置抗锯齿
          elevation: 0.0, // 设置阴影大小
          child: Column(children: [
            Gap.h10,
            // 标题
            BigTitleWidgetView(
              title: titleS,
              // isShowTip: true,
            ),
            // 间距
            // Gap.h10,
            GetBuilder<AppCenterPageController>(builder: (controller) {
              return controller.allAppList.isEmpty
                  ? const Text("")
                  : Container(child: _gridViewWidget(listData, isCom));
            })
          ]),
        ));
  }

  // gridview
  Widget _gridViewWidget(listData, isCom) {
    return MasonryGridView.count(
        padding: EdgeInsets.only(
            top: ScreenAdapter.height(30), bottom: ScreenAdapter.height(30)),
        crossAxisCount: 4,
        crossAxisSpacing: ScreenAdapter.width(5), //
        mainAxisSpacing: ScreenAdapter.width(40), //行间距
        itemCount: listData.length, //注意
        shrinkWrap: true, //收缩，让元素宽度自适应
        physics: const NeverScrollableScrollPhysics(), //禁止滑动）
        itemBuilder: (context, index) {
          return GetBuilder<AppCenterPageController>(builder: ((controller) {
            var item = listData[index];
            return itemWidget(
                controller.isEdit, item, index, isCom, controller, context);
          }));
        });
  }

// 每一个item
  Widget _gridViewItemWidget(isEdit, item, index, isCom, context) {
    String imgae = "";
    bool status = item["status"];
    if (isCom) {
      status = false;
      imgae = 'imgs/icons/disable.png';
    } else {
      imgae = 'imgs/icons/add_set-blue.png';
    }
    // 这里不能使用inkwell,拖拽的时候会引起层级问题
    return GestureDetector(
        onTap: () {
          if (isEdit) {
            controller.clickItemChangeStatus(status, isCom, item);
          } else {
            controller.getFormConfigOfId(item["id"]);
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            isEdit
                ? Positioned(
                    right: 10,
                    top: 0,
                    child: Container(
                        // color: Colors.red,
                        child: !status
                            ? Image.asset(
                                imgae,
                                width: 16,
                              )
                            : const Text("")))
                : const Text(""),
            Column(
              children: [
                itemWithIconWidget(item, index, context),
                Container(
                  margin: EdgeInsets.only(top: ScreenAdapter.height(8)),
                  child: Text(
                    item["name"],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: ScreenAdapter.fontSize(24),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }

// 图标
  Widget itemWithIconWidget(item, index, context) {
    dynamic content = Ep.menu;
    String icon = "${item["icon"]}".toLowerCase();
    return FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('imgs/fonts/iconfont.json'),
        builder: ((context, snapshot) {
          if (icon.contains("iconfont")) {
            List imgs = icon.split(" ");
            var map = json.decode(snapshot.data.toString());
            if (snapshot.connectionState == ConnectionState.done) {
              List icons =
                  List<IconModel>.from(map["glyphs"].map((icon) => IconModel(
                        name: "icon-${icon['font_class']}",
                        codePoint: icon['unicode_decimal'],
                      )));
              for (var element in icons) {
                if (element.name == imgs.last) {
                  content = element.codePoint;
                }
              }
            }
          } else {
            icon = icon.replaceAll("i-ep-", "");
            icon = icon.contains("-") ? icon.replaceAll("-", "_") : icon;
            if (IconifyEp.iconsList.containsKey(icon)) {
              content = IconifyEp.iconsList[icon.toLowerCase()];
            }
          }
          Widget child = (content is int)
              ? Icon(
                  IconData(content, fontFamily: 'IconFontIcons'),
                  color: Colors.grey.shade800,
                )
              : Iconify(
                  content,
                  color: Colors.grey.shade800,
                );
          return child;
        }));
  }

  ///Item，裹上LongPressDraggable，使其可长按拖拽
  Widget itemWidget(isEdit, item, index, isCom, controller, context) {
    return isCom
        ? LongPressDraggable(
            data: index,

            ///拖拽时候显示的组件
            feedback: _gridViewItemWidget(
                controller.isEdit, item, index, isCom, context),

            ///组件拖拽的回调
            child: DragTarget<int>(
              onAccept: (data) {
                controller.handleReorder(data, index);
              },
              builder: (context, candidateData, rejectedData) {
                return Container(
                  child: _gridViewItemWidget(
                      controller.isEdit, item, index, isCom, context),
                );
              },
            ),
          )
        : _gridViewItemWidget(controller.isEdit, item, index, isCom, context);
  }
}
