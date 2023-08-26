import 'package:get/get.dart';

import '../../../../../../component/common/others.dart';
import '../../../../../../component/common/progress_hud.dart';
import '../../../../../../config/config.dart';
import '../../../../../../http/data_utils.dart';

class MeetingSelectPersonController extends GetxController {
  List personList = [];
  List selectedPerson = [];
  List oldPersonList = Get.arguments["selectedPerson"];
  int source = Get.arguments["source"];
  bool multiple = Get.arguments["multiple"];
  bool isSearch = Get.arguments["isSearch"]; // 是否添加搜索框
  List orgList = Get.arguments["orgList"];
  String valueKey = Get.arguments["valueKey"];
  String url = Get.arguments["url"] ?? "";

  var pageIndex = 1; // 页数
  bool hasMore = true;

  @override
  void onInit() {
    super.onInit();
    // 处理上个页面传过来的数据
    if (oldPersonList.isNotEmpty) {
      List newList = copyWithList(oldPersonList);
      selectedPerson.addAll(newList);
    }
    if (source != 0) {
      getModelConfigOfIdData();
    } else {
      // 调整数据
      for (var element in orgList) {
        Map objMap = {};
        objMap["name"] = element["name"];
        objMap["status"] = false;
        objMap["id"] = element["id"];

        // 上个页面添加的数据
        for (var selItem in selectedPerson) {
          if (selItem["id"] == element["id"]) {
            objMap = selItem;
          }
        }
        personList.add(objMap);
      }
      update();
    }
  }

  @override
  void dispose() {
    super.dispose();
    personList.clear();
  }

  // 点击选择加入或移除
  changeSelectStatus(obj, status) {
    if (multiple) {
      obj["status"] = status;
      if (status) {
        selectedPerson.add(obj);
      } else {
        if (oldPersonList.isEmpty) {
          selectedPerson.remove(obj);
        } else {
          obj["status"] = false;
          selectedPerson.remove(obj);
        }
      }
    } else {
      selectedPerson.clear();
      obj["status"] = status;
      selectedPerson.add(obj);
      Get.back(result: selectedPerson);
    }

    update();
  }

  // 点击移除头像
  removePerson(obj) {
    selectedPerson.remove(obj);
    obj["status"] = !obj["status"];
    update();
  }

  // 获取二级页面的数据
  getModelConfigOfIdData() {
    DataUtils.getModelConfigOfId(source, null, success: (data) {
      if (data["code"] == 200) {
        url = data["data"]["url"];
        url = '${Config.severBaseUrl}$url';
        getOtherDatas(url);
      } else {
        ProgressHUD.showError(data["msg"]);
      }
    }, fail: (code) {});
  }

  // 获取model对应的数据
  getOtherDatas(url) {
    DataUtils.getMyCommonList(url, {"page": pageIndex, "page_size": 20},
        success: (data) {
      if (data["code"] == 200) {
        Map dataMap = data["data"];
        List listData = dataMap["results"];

        if (listData.isNotEmpty) {
          if (pageIndex == 1) {
            personList.clear();
          }

          for (var element in listData) {
            Map objMap = {};
            objMap["name"] = element["choices_key"];
            objMap["status"] = false;
            objMap["id"] = element["id"];

            // 搜索添加的数据
            for (var selItem in selectedPerson) {
              if (selItem["id"] == element["id"]) {
                objMap = selItem;
              }
            }
            personList.add(objMap);
          }
          if (dataMap["total"] <= personList.length) {
            hasMore = false;
          } else {
            hasMore = true;
          }
        } else {
          ProgressHUD.showInfo("暂无数据！");
        }
        update();
      } else {
        ProgressHUD.showError(data["msg"]);
      }
    }, fail: (error) {});
  }

  // 搜索页添加选择的人
  addSearchDataToHome(item) {
    Map objMap = {};
    objMap["name"] = item["name"];
    objMap["status"] = true;
    objMap["id"] = item["id"];
    if (multiple) {
      // 先判断列表中是否存在这个人，存在就直接改数据，不存在就再添加新的
      var isCon = personList.any((e) => e["id"] == item["id"]);
      if (isCon) {
        for (var element in personList) {
          if (element["id"] == item["id"]) {
            element["status"] = true;
            if (!selectedPerson.contains(element)) {
              selectedPerson.add(element);
            }
          }
        }
      } else {
        objMap["status"] = true;
        if (!selectedPerson.contains(objMap)) {
          selectedPerson.add(objMap);
        }
      }
    } else {
      selectedPerson.clear();
      selectedPerson.add(objMap);
      Get.back(result: selectedPerson);
    }

    update();
  }
}
