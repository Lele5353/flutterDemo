import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../component/common/progress_hud.dart';
import '../../../../../../http/data_utils.dart';
import '../../../model/notice_model.dart';

class NoticeListPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  List tabs = ["制度", "通报", "通知", "其他"];
  late TabController tabController;
  var pageIndex = 1; // 页数
  bool hasMore = false;
  GlobalKey contentKey = GlobalKey();
  GlobalKey refresherKey = GlobalKey();
  // 数据列表
  List noticeList = [];
  bool isNoNdata = true;
  bool isLoading = true;
  final PageController pageController = PageController(initialPage: 0);

  @override
  void onInit() {
    super.onInit();
    getAnnouncementListData(0);
    tabController = TabController(
      vsync: this,
      length: tabs.length,
    );
    // ..addListener(() {
    //     if (!tabController.indexIsChanging) {
    //       tabController.index == tabController.animation!.value;
    //       changeTabIndex(tabController.index);
    //     }
    //   });
  }

  @override
  void dispose() {
    tabController.dispose();
    pageController.dispose();
    super.dispose();
  }

  // 公告列表
  getAnnouncementListData(type) {
    DataUtils.getAnnouncementWithType(
        type, {"page_size": 10, "page": pageIndex}, success: (data) {
      // isLoading = false;
      if (data["code"] == 200) {
        NoticeModel model = NoticeModel.fromJson(data);

        Data datas = model.data!;
        List results = datas.results!;
        if (results.isNotEmpty) {
          if (pageIndex == 1) {
            noticeList.clear();
          }
          noticeList.addAll(results);
          if (datas.total! <= noticeList.length) {
            hasMore = false;
          } else {
            hasMore = true;
          }
          isNoNdata = false;
          isLoading = false;
        } else {
          isLoading = false;
          isNoNdata = true;
          pageIndex = 1;
        }
      } else {
        isLoading = false;
        ProgressHUD.showSuccess(data["msg"]);
      }
      update();
    }, fail: (code) {
      isLoading = false;
    });
  }

  // 获取当前公告的type
  getAnnouncemenType(int num) {
    switch (num) {
      case 0:
        return "制度";
      case 1:
        return "通报";
      case 2:
        return "通知";
      case 3:
        return "其他";
      default:
    }
  }

  void backAndRefreshNotice(BuildContext context, url, argument) async {
    final result = await Get.toNamed('$url', arguments: argument);
    // 可以做的操作
    if (result != null) {
      getAnnouncementListData(tabController.index);
      update();
    }
  }

  // 滑动或者点击tabbar
  changeTabIndex(index) {
    tabController.index = index;
    isNoNdata = true;
    isLoading = true;
    pageIndex = 1; // 页数
    hasMore = false;
    noticeList.clear();
    update();
    getAnnouncementListData(index);
  }
}
