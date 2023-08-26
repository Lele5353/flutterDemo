import 'package:get/get.dart';

import '../../../../../../component/common/others.dart';
import '../../../../../../component/common/progress_hud.dart';
import '../../../../../../http/data_utils.dart';
import '../../../../../../http/dio_utils.dart';

class AppCenterPageController extends GetxController {
  List comListData = Get.arguments["listData"];
  List allListData = Get.arguments["allData"];
  bool isEdit = false;
  bool isDrag = false;
  List allAppList = [];
  List commonList = [];

  int overlapIndex = -1;
  bool showSrcElement = false;
  List newList = [];

  @override
  void onInit() {
    super.onInit();
    getNewAllDatas();
  }

  // 更改编辑状态
  changeEditStatus() {
    if (isEdit) {
      submitToServer();
    }
    isEdit = !isEdit;
    isDrag = isEdit;
    update();
  }

// 全部应用
  getNewAllDatas() {
    allAppList = copyWithList(allListData);
    commonList = copyWithList(comListData);

    for (Map all in allAppList) {
      all.addAll({"status": false});
      for (Map element in commonList) {
        element.addAll({"status": true});
        if (element["name"] == all["name"]) {
          all.addAll({"status": true});
        }
      }
    }
    update();
  }

  // 点击item切换状态
  clickItemChangeStatus(status, isCom, item) {
    if (isCom) {
      // 删除常用应用中的item
      if (commonList.length == 1) {
        ProgressHUD.showText("常用不能为空!");
      } else {
        for (Map all in allAppList) {
          if (item["name"] == all["name"]) {
            all.addAll({"status": false});
            commonList.remove(item);
          }
        }
      }
    } else {
      // 网常用应用中添加，同时判断是否超过12个，如果超过12个就不能添加
      if (commonList.length > 11) {
        ProgressHUD.showText("常用不能超过12个!");
      } else {
        for (Map all in allAppList) {
          if (item["name"] == all["name"] && status == false) {
            all.addAll({"status": true});
            commonList.add(all);
          }
        }
      }
    }
    update();
  }

  // 点击完成，提交修改后的常用应用
  submitToServer() {
    // 获取常用应用的所有id
    List ids = [];
    for (var element in commonList) {
      ids.add(element["id"]);
    }
    DataUtils.updateShortcutForms(Method.put, {"form_config": ids},
        success: (data) {
      if (data["code"] == 200) {
        ProgressHUD.showSuccess(data["msg"]);
        // Get.back(result: 'addRef');
      } else {
        ProgressHUD.showError(data["msg"]);
      }
    }, fail: (code) {});
  }

  // 拖拽以后更新列表数据
  void handleReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    // 先更新目前视图等到点击完成时再更新整体list
    final element = commonList.removeAt(oldIndex);
    commonList.insert(newIndex, element);
    update();
  }

  getFormConfigOfId(id) {
    DataUtils.getFormConfigOfId(id, null, success: (data) {
      if (data["code"] == 200) {
        Get.toNamed('/flow-page', arguments: {"dataMap": data["data"]});
      } else {
        ProgressHUD.showError(data["msg"]);
      }
    }, fail: (code) {});
  }
}
