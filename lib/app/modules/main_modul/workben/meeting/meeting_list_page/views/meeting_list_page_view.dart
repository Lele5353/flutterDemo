import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../../component/common/color_untils.dart';
import '../../../../../../component/common/no_scroll_behavior.dart';
import '../../../../../../component/common/screen_adapter.dart';
import '../../../../../../component/common_widgets/common_navi_widget.dart';
import '../../../../../../component/common_widgets/common_shimmer_widget.dart';
import '../../../../../../component/common_widgets/gap.dart';
import '../../../../address_book/search_page/views/empty_search_page.dart';
import '../controllers/meeting_list_page_controller.dart';
import 'meeting_group_list.dart';

class MeetingListPageView extends GetView<MeetingListPageController> {
  const MeetingListPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.line,
      appBar: commonAppNaviBar(context, '会议记录', 1, true),
      body: _myContent(context),
    );
  }

  Widget _myContent(context) {
    return ScrollConfiguration(
        behavior: NoScrollBehavior(),
        child: Column(
          children: [
            _titleTabsWidget(),
            Gap.lineH1,
            Expanded(
              child:
                  GetBuilder<MeetingListPageController>(builder: (controller) {
                if (controller.isLoading) {
                  return _buildShimmer();
                } else {
                  if (controller.isNoNdata) {
                    return const NotSearchPage(
                      iconPath: "imgs/nodatas/no_meeting.png",
                      title: "暂无数据",
                    );
                  }
                  return _buildTableBarView();
                }
              }),
            ),
            Gap.h10
          ],
        ));
  }

  // 列表内容页面
  Widget _buildTableBarView() {
    return GetBuilder<MeetingListPageController>(builder: (controller) {
      return PageView.builder(
          itemCount: controller.tabs.length,
          onPageChanged: (index) {
            controller.changeTabIndex(index);
          },
          controller: controller.pageController,
          itemBuilder: (_, int index) {
            return MeetingGroupList(
              currentIndex: controller.currentTabsIndex,
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
        onTap: (tab) {
          controller.changeTabIndex(tab);
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

// 加载光影
  Widget _buildShimmer() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(
              top: 10,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
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
                  children: const [
                    CommonShimmerWidget(
                      width: 222,
                      height: 20,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CommonShimmerWidget(
                      width: 16,
                      height: 16,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              CommonShimmerWidget(
                                width: 230,
                                height: 16,
                              ),
                              CommonShimmerWidget(
                                width: 30,
                                height: 16,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CommonShimmerWidget(
                      width: 16,
                      height: 16,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              CommonShimmerWidget(
                                width: 180,
                                height: 16,
                              ),
                              CommonShimmerWidget(
                                width: 60,
                                height: 16,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CommonShimmerWidget(
                      width: 16,
                      height: 16,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              CommonShimmerWidget(
                                width: 200,
                                height: 16,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
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
