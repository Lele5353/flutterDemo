/// 控制台模块controller

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../config/config.dart';
import '../../../../../http/data_utils.dart';
import '../../../../../component/common/progress_hud.dart';
import '../../../../../store/services/user_service.dart';
import '../../model/notice_model.dart';

class WorkController extends GetxController {
  RxString username = "".obs;
  List applyForms = [];
  int meetingApplyId = 0; // 会议申请id
  List allForms = []; // 全部应用
  bool loginStstus = false;
  int waitingCount = 0;
  int applyCount = 0;
  int copyCount = 0;

  List backImgUrls = [
    "imgs/notice_bg/1.JPG",
    "imgs/notice_bg/2.JPG",
    "imgs/notice_bg/3.jpg",
    "imgs/notice_bg/8.jpg",
    "imgs/notice_bg/4.jpg",
  ];
  // 公告
  List noticeList = [];
  bool hasData = true;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  late Worker worker;

  // @override
  // void onInit() {
  //   super.onInit();
  //   // checkIfLoggedIn();
  // }

  // 判断是否登录
  void checkIfLoggedIn() async {
    bool isLogin = await UserServices.getUserLoginState();
    if (isLogin) {
      getAnnouncementListData();
      getApplyFormsDatas();
      getAllAppsDatas();
      getAllData();
    }
  }

// 获取常用应用
  getApplyFormsDatas() {
    DataUtils.getShortcutFormsList(null, success: (data) {
      applyForms.clear();
      if (data['code'] == 200) {
        List datas = data["data"];
        applyForms.addAll(datas);
      } else {
        ProgressHUD.showError(data["msg"]);
      }
      update();
    }, fail: (code) {});
  }

// 获取全部应用
  getAllAppsDatas() {
    DataUtils.getApplyFormsList(null, success: (data) {
      allForms.clear();
      if (data['code'] == 200) {
        List datas = data["data"];
        allForms.addAll(datas);
        for (var item in datas) {
          if (item["name"] == "会议室申请") {
            meetingApplyId = item["id"];
          }
        }
      } else {
        ProgressHUD.showError(data["msg"]);
      }
      update();
    }, fail: (code) {});
  }

//判断用户有没有登录
  checkout() async {
    bool loginStstus = await UserServices.getUserLoginState();
    if (!loginStstus) {
      //执行跳转
      Get.toNamed("/login");
    }
  }

// 导航返回时刷新数据
  void navigateAndRefresh(BuildContext context, List listdata) async {
    final result = await Get.toNamed('/app-center-page', arguments: {
      "listData": listdata,
      "allData": allForms,
    });
    // 可以做的操作
    if (result == "addRef") {
      getApplyFormsDatas();
    }
  }

// 获取表单配置
  getFormConfigOfId(id, context) {
    DataUtils.getFormConfigOfId(id, null, success: (data) {
      if (data["code"] == 200) {
        jumpIntoMyApproval(context, {"dataMap": data["data"]}, '/flow-page');
        // Get.toNamed('/flow-page', arguments: {"dataMap": data["data"]});
      } else {
        ProgressHUD.showError(data["msg"]);
      }
    }, fail: (code) {});
  }

  // 公告列表
  getAnnouncementListData() {
    DataUtils.getAnnouncement({"page_size": 5, "page": 1}, success: (data) {
      if (data["code"] == 200) {
        NoticeModel model = NoticeModel.fromJson(data);
        noticeList.clear();
        Data datas = model.data!;
        List results = datas.results!;
        if (results.isNotEmpty) {
          noticeList.addAll(results);
          hasData = true;
        } else {
          hasData = false;
        }
        update();
      } else {
        ProgressHUD.showError(data["msg"]);
        hasData = false;
      }
    }, fail: (code) {});
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

// 刷新公告
  void backAndRefreshNotice(BuildContext context, url, argument) async {
    final result = await Get.toNamed('$url', arguments: argument);
    // 可以做的操作
    if (result != null) {
      // getAnnouncementListData();
      // update();
    }
  }

  // 跳转进入我的待办
  jumpIntoMyApproval(BuildContext context, arguments, url) async {
    // final result = await Get.toNamed('/mine-approval', arguments: arguments);
    final result = await Get.toNamed(url, arguments: arguments);
    if (result != null) {
      // 刷新待办的数量
      getAllData();
      // update();
    }
  }

  getAllData() {
    getListCountForMyPending();
    getListCountForMyApply();
    getListCountForMyCopy();
  }

// 获取待审批的数量
  getListCountForMyPending() {
    DataUtils.getMyCommonList(Config.minePendingList, {
      "page": 1,
      "page_size": 10,
    }, success: (data) {
      if (data["code"] == 200) {
        Map datas = data["data"];
        List results = datas["results"];
        waitingCount = results.length;
      } else {
        ProgressHUD.showError(data["msg"]);
      }
      update();
    }, fail: (code) {});
  }

  // 获取申请待审批数量
  getListCountForMyApply() {
    DataUtils.getMyCommonList(Config.mineApplyList, {
      "page": 1,
      "page_size": 10,
    }, success: (data) {
      if (data["code"] == 200) {
        Map datas = data["data"];
        List results = datas["results"];
        int count = 0;
        for (var element in results) {
          if (element["state"] == 0) {
            count++;
          }
        }
        applyCount = count;
      } else {
        ProgressHUD.showError(data["msg"]);
      }
      update();
    }, fail: (code) {});
  }

  // 获取抄送数量
  getListCountForMyCopy() {
    DataUtils.getMyCommonList(Config.mineCopyList, {
      "page": 1,
      "page_size": 10,
    }, success: (data) {
      if (data["code"] == 200) {
        Map datas = data["data"];
        List results = datas["results"];
        copyCount = results.length;
      } else {
        ProgressHUD.showError(data["msg"]);
      }
      update();
    }, fail: (code) {});
  }
}
