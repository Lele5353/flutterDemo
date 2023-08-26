import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../../component/common/color_untils.dart';
import '../../../../../../component/common/screen_adapter.dart';
import '../../../../../../component/common/no_scroll_behavior.dart';
import '../../../../../../component/common_widgets/common_navi_widget.dart';
import '../../../../../../component/common_widgets/common_shimmer_widget.dart';
import '../../../../../../component/common_widgets/gap.dart';
// import '../../../../../../component/common_widgets/common_shimmer_widget.dart';
import '../../../../../../router/router_utils.dart';
import '../../../../address_book/search_page/views/empty_search_page.dart';
import '../../../../address_book/search_page/views/search_page_view.dart';
import '../controllers/notice_list_page_controller.dart';
import 'notice_list_view.dart';

class NoticeListPageView extends GetView<NoticeListPageController> {
  const NoticeListPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppNaviBar(context, "公告", 1, true, backCallBack: () {
        Get.back(result: 'refreshHome');
      },
          rightWidget: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(ScaleRouter(
                        child: const SearchPageView(
                      key: ValueKey("noticeSearch"),
                      url: "",
                      hintText: "请输入搜索内容",
                    )))
                    .then((value) => {if (value != null) {}});
              },
              icon: Image.asset(
                "imgs/nodatas/nav_search.png",
                width: 25,
              ))),
      body: WillPopScope(
          child: _myContent(context),
          onWillPop: () async {
            Get.back(result: 'refreshHome');
            return false;
          }),
    );
  }

  Widget _myContent(context) {
    return ScrollConfiguration(
        behavior: NoScrollBehavior(),
        child: Column(
          children: [
            _titleTabsWidget(),
            Gap.lineH1,
            Expanded(child:
                GetBuilder<NoticeListPageController>(builder: (controller) {
              if (controller.isLoading) {
                return _buildShimmer();
              } else {
                if (controller.isNoNdata) {
                  return const NotSearchPage(
                    title: "暂无数据",
                    isHiddenIcon: true,
                    iconPath: "imgs/nodatas/no_data.png",
                  );
                }
                return _buildTableBarView();
              }
            })),
            Gap.h10,
          ],
        ));
  }

// 列表内容页面
  Widget _buildTableBarView() {
    return GetBuilder<NoticeListPageController>(builder: (controller) {
      return PageView.builder(
          itemCount: controller.tabs.length,
          onPageChanged: (index) {
            controller.changeTabIndex(index);
          },
          controller: controller.pageController,
          itemBuilder: (_, int index) {
            return Container(
              color: ColorUtils.line,
              child: const NoticeListView(),
            );
          });
    });
  }

  // tabs的设置
  Widget _titleTabsWidget() {
    return Container(
      alignment: Alignment.center,
      width: ScreenAdapter.screenWidth(),
      color: Colors.white,
      child: TabBar(
        onTap: (value) {
          controller.changeTabIndex(value);
        },
        labelStyle: TextStyle(
            fontSize: ScreenAdapter.fontSize(30),
            fontWeight: FontWeight.normal),
        unselectedLabelStyle: TextStyle(fontSize: ScreenAdapter.fontSize(29)),
        isScrollable: true,
        controller: controller.tabController,
        labelColor: ColorUtils.appMain,
        indicatorWeight: 1.5,
        // 下标条的长度，值越大，长度越短
        indicatorPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        unselectedLabelColor: ColorUtils.text,
        indicatorColor: ColorUtils.appMain,
        tabs: controller.tabs.map((e) => Tab(text: e)).toList(),
      ),
    );
  }

  /// 加载光影
  Widget _buildShimmer() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(
              top: 10,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0D000000),
                  offset: Offset(0.0, 1.0),
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        CommonShimmerWidget(
                          width: 16,
                          height: 16,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        CommonShimmerWidget(
                          width: 230,
                          height: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
