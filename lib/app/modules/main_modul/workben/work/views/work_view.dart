import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutteroa/app/config/config.dart';
import 'package:get/get.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../component/common/color_untils.dart';
import '../../../../../component/common/screen_adapter.dart';
import '../../../../../component/common_widgets/gap.dart';
import '../../model/notice_model.dart';
import '../controllers/work_controller.dart';
import '../widgets/app_group_widget_view.dart';
import '../widgets/big_title_widget_view.dart';
import '../widgets/cardwidget_view.dart';
// import 'notice_view.dart';

class WorkView extends GetView<WorkController> {
  final List cylistData;
  const WorkView({
    Key? key,
    required this.cylistData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //设置状态栏的背景颜色
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      //状态栏的文字的颜色
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: ColorUtils.scaffoldBgLight,
      body: _buildRefreshView(context),
    );
  }

  Widget _buildContent(context) {
    return Container(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: SizedBox(
          // color: Colors.white,
          child: Column(
            children: [
              // 间距
              Gap.h10,
              // 轮播图
              _swiperWidget(context),
              // 中间内容
              _contentWidegt(context)
            ],
          ),
        ),
      ),
    );
  }

// 轮播图
  Widget _swiperWidget(context) {
    return GetBuilder<WorkController>(builder: (controller) {
      return Container(
        margin: EdgeInsets.only(
            top: ScreenAdapter.height(0),
            left: ScreenAdapter.width(30),
            right: ScreenAdapter.width(30)),
        height: ScreenAdapter.height(250),
        child: Swiper(
          key: UniqueKey(),
          itemBuilder: (context, index) {
            if (controller.noticeList.isNotEmpty) {
              Results model = controller.noticeList[index];
              String typeS = controller.getAnnouncemenType(model.type!);
              return ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: AssetImage(
                        controller.backImgUrls[index],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    child: Center(
                      child: Text(
                        '【$typeS】${model.title!}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: ScreenAdapter.fontSize(35),
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: AssetImage(
                        controller.backImgUrls[0],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    child: Center(
                      child: Text(
                        '典道办公系统',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: ScreenAdapter.fontSize(35),
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              );
            }
          },
          itemCount:
              controller.backImgUrls.length > controller.noticeList.length
                  ? (controller.noticeList.isEmpty
                      ? 1
                      : controller.noticeList.length)
                  : controller.backImgUrls.length,
          pagination: const SwiperPagination(
              builder: RectSwiperPaginationBuilder(
            color: Color.fromRGBO(200, 200, 200, 0.5),
          )),
          autoplay: true,
          loop: true,
          onTap: (index) {
            if (controller.noticeList.isNotEmpty) {
              Results model = controller.noticeList[index];
              controller.backAndRefreshNotice(context, '/notice-detail-page',
                  {"title": model.title, "itemData": model});
            }
          },
        ),
      );
    });
  }

  // 可滑动内容组件
  Widget _contentWidegt(context) {
    return Column(
      children: [
        // 间距
        Gap.h10,
        _centerWidage(context),
        // 间距
        Gap.h5,
        CardwidgetView(
          titleText: "常用",
          showList: cylistData,
          isShowTab: false,
          tabbarWidget: const Text(""),
          tabbarView: const Text(""),
        ),
        // 会议模块
        _meetingWidget(context),
        // 间距
        Gap.h5,
      ],
    );
  }

  // 会议
  Widget _meetingWidget(context) {
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
            // 间距
            Gap.h10,
            // 标题
            const BigTitleWidgetView(
              title: '会议',
              // isShowTip: true,
            ),
            // 间距
            Gap.h10,
            GetBuilder<WorkController>(builder: (controller) {
              return AppGroupWidgetView(
                listData: Config.meetingList,
                itemH: 40,
                isSvg: false,
                onTapItemCallBack: (index) {
                  if (index == 0) {
                    // 会议申请
                    controller.getFormConfigOfId(
                        controller.meetingApplyId, context);
                  } else if (index == 1) {
                    Get.toNamed('/meeting-list-page');
                  } else {
                    Get.toNamed('/meeting-apply-page');
                  }
                },
              );
            })
          ]),
        ));
  }

// 下拉刷新
  Widget _buildRefreshView(context) {
    return SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        physics: const BouncingScrollPhysics(),
        header: const WaterDropHeader(
          complete: Text(""), // 加载完以后显示的文字
        ),
        controller: controller.refreshController,
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 1000));
          controller.refreshController.refreshToIdle();
          controller.getAnnouncementListData(); // 公告
          controller.getApplyFormsDatas(); // 常用应用
          controller.getAllAppsDatas(); // 全部应用
          controller.getAllData(); // 待办数量
        },
        child: _buildContent(context));
  }

  // 我的事项
  Widget _centerWidage(context) {
    return Card(
      margin: EdgeInsets.only(
          left: ScreenAdapter.width(30), right: ScreenAdapter.width(30)),
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: SizedBox(
        child: GetBuilder<WorkController>(builder: (controller) {
          return ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _itemWithCenterWidget("申请", 0, 'imgs/worken/approval_apply.png',
                  context, controller.applyCount),
              _itemWithCenterWidget("审批", 1, 'imgs/worken/approval_waiting.png',
                  context, controller.waitingCount),
              _itemWithCenterWidget("抄送", 2, 'imgs/worken/approval_copy.png',
                  context, controller.copyCount),
              _itemWithCenterWidget(
                  "完成", 3, 'imgs/worken/approval_finish.png', context, 0),
            ],
          );
        }),
      ),
    );
  }

  Widget _itemWithCenterWidget(text, index, imgPath, context, count) {
    return InkWell(
        onTap: () {
          controller.jumpIntoMyApproval(
              context, {"navTitle": text, "index": index}, '/mine-approval');
        },
        child: Column(
          children: [
            Gap.h5,
            count != 0
                ? Badge(
                    label: bageWidget(count),
                    // alignment: const AlignmentDirectional(15, -5),
                    child: Image.asset(
                      imgPath,
                      width: 20,
                      color: ColorUtils.botNavMainColor,
                    ),
                  )
                : Image.asset(
                    imgPath,
                    color: ColorUtils.botNavMainColor,
                    width: 20,
                  ),
            Gap.h5,
            Text(text,
                style: TextStyle(
                    color: ColorUtils.text,
                    fontSize: ScreenAdapter.fontSize(26))),
            Gap.h5,
          ],
        ));
  }

  Widget bageWidget(badgeCount) {
    return Align(
      alignment: Alignment.topRight,
      child: Center(
        // 将文本居中
        child: Text(
          badgeCount.toString(),
          textAlign: TextAlign.center, // 设置文本的对齐方式为居中
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenAdapter.fontSize(22),
            // fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
