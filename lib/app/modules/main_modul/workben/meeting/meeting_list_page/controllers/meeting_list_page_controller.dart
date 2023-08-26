import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../component/common/progress_hud.dart';
import '../../../../../../http/data_utils.dart';
import '../models/meeting_apply_list_model.dart';

class MeetingListPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  List tabs = ["进行中", "未开始", "已结束"];
  late TabController tabController;
  int currentTabsIndex = 0;

  var pageIndex = 1; // 页数
  bool hasMore = true;
  GlobalKey contentKey = GlobalKey();
  GlobalKey refresherKey = GlobalKey();

  List dataList = [];
  bool isNoNdata = true;
  bool isLoading = true;
  final PageController pageController = PageController(initialPage: 0);

  @override
  void onInit() {
    super.onInit();
    checkMeetingApplyListData();
    tabController = TabController(
        vsync: this, length: tabs.length, initialIndex: currentTabsIndex);
    // ..addListener(() {
    //   if (!tabController.indexIsChanging) {
    //     currentTabsIndex = tabController.index;
    //     tabController.index == tabController.animation!.value;
    //     changeTabIndex(currentTabsIndex);
    //   }
    // });
  }

  @override
  void dispose() {
    tabController.dispose();
    pageController.dispose();
    super.dispose();
  }

  void checkMeetingApplyListData() {
    DataUtils.getMeetingApplyList({"page": pageIndex, "page_size": 10},
        success: (data) {
      if (data["code"] == 200) {
        Map datas = data["data"];
        if (datas["total"] > 0) {
          MeetingApplyData meetingApplyData =
              MeetingApplyData.fromJson(data["data"]);
          List listData = meetingApplyData.results!;

          if (pageIndex == 1) {
            dataList.clear();
          }
          for (MeetingApplyResults element in listData) {
            DateTime dateTime = DateTime.parse(element.startDate!);
            String date = formatDate(dateTime, [m, '月', dd, "日"]);
            String weekday = getWeekday(dateTime);
            date = '$date $weekday';
            element.updateTime = date;
            if (currentTabsIndex == 0) {
              if (element.meetingStatus == "进行中") {
                dataList.add(element);
              }
            } else if (currentTabsIndex == 1) {
              if (element.meetingStatus == "未开始") {
                dataList.add(element);
              }
            } else {
              if (element.meetingStatus == "已结束") {
                dataList.add(element);
              }
            }
          }

          if (meetingApplyData.total! <= dataList.length) {
            hasMore = false;
          } else {
            hasMore = true;
          }
        } else {
          // ProgressHUD.showInfo("暂无数据！");
        }

        if (dataList.isNotEmpty) {
          isNoNdata = false;
          isLoading = false;
        } else {
          isNoNdata = true;
          isLoading = false;
        }

        update();
      } else {
        ProgressHUD.showError(data["msg"]);
      }
    }, fail: (code) {
      isLoading = false;
    });
  }

  // 星期title的替换
  static String getWeekday(DateTime dateTime) {
    String weekday = '';
    switch (dateTime.weekday) {
      case 1:
        weekday = '周一';
        break;
      case 2:
        weekday = '周二';
        break;
      case 3:
        weekday = '周三';
        break;
      case 4:
        weekday = '周四';
        break;
      case 5:
        weekday = '周五';
        break;
      case 6:
        weekday = '周六';
        break;
      case 7:
        weekday = '周日';
        break;
      default:
        break;
    }
    return weekday;
  }

  // 滑动或者点击tabbar
  changeTabIndex(index) {
    tabController.index = index;
    currentTabsIndex = index;
    isNoNdata = true;
    isLoading = true;
    pageIndex = 1; // 页数
    hasMore = true;
    dataList.clear();
    update();
    checkMeetingApplyListData();
  }
}
