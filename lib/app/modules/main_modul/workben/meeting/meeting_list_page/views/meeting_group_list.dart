import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../../component/common/screen_adapter.dart';
import '../controllers/meeting_list_page_controller.dart';
import '../models/meeting_apply_list_model.dart';
import 'meeting_item_card_view.dart';

class MeetingGroupList extends StatefulWidget {
  final int currentIndex;
  const MeetingGroupList({super.key, this.currentIndex = 0});

  @override
  State<MeetingGroupList> createState() => _MeetingGroupListState();
}

class _MeetingGroupListState extends State<MeetingGroupList> {
  final MeetingListPageController controller =
      Get.put(MeetingListPageController());
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  refreshListCallBack() async {
    refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        physics: const BouncingScrollPhysics(),
        header: const WaterDropHeader(
          complete: Text(""), // 加载完以后显示的文字
        ),
        footer: const ClassicFooter(
          loadStyle: LoadStyle.ShowWhenLoading,
          completeDuration: Duration(milliseconds: 500),
          loadingText: "",
          idleText: "上拉加载更多",
          noDataText: "到底啦",
        ),
        controller: refreshController,
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 1000));
          refreshController.refreshToIdle();
          controller.pageIndex = 1;
          controller.checkMeetingApplyListData();
        },
        onLoading: () async {
          await Future.delayed(const Duration(milliseconds: 1000));
          if (controller.hasMore) {
            controller.pageIndex++;
            controller.checkMeetingApplyListData();
            refreshController.loadComplete();
          } else {
            refreshController.loadNoData();
          }
        },
        child: GetBuilder<MeetingListPageController>(builder: (controller) {
          return GroupedListView<dynamic, String>(
            elements: controller.dataList,
            groupBy: (data) => data.updateTime,
            groupComparator: (value1, value2) => value2.compareTo(value1),
            // itemComparator: (item1, item2) =>
            //     item1['name'].compareTo(item2['name']),
            // order: GroupedListOrder.DESC,
            // useStickyGroupSeparators: true,
            groupSeparatorBuilder: (String value) => Padding(
              padding: EdgeInsets.only(
                  left: ScreenAdapter.width(40),
                  top: ScreenAdapter.height(20),
                  bottom: ScreenAdapter.height(10)),
              child: Text(
                value,
                style: TextStyle(
                    fontSize: ScreenAdapter.fontSize(30),
                    color: Colors.grey.withOpacity(0.9)),
              ),
            ),
            itemBuilder: (c, element) {
              return _sliderWidget(
                  element, controller.dataList.indexOf(element), context);
            },
          );
        }));
  }

  Widget _sliderWidget(MeetingApplyResults item, index, context) {
    return Slidable(
      // 必填项，用于标记每一个item
      key: ValueKey(index.toString()),
      // 从右往左滑
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.2, // 设置按钮的宽度
        children: [
          SlidableAction(
            onPressed: (context) {
              // setState(() {
              //   _controller.updateList(index, showList);
              // });
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
            // icon: Icons.delete,
            label: '删除',
          )
        ],
      ),
      child: MeetingItemCardView(
        currentIndex: widget.currentIndex,
        item: item,
        isStar: true,
      ),
    );
  }
}
