import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../../component/common/others.dart';
import '../../../../../../component/common/progress_hud.dart';
import '../../../../../../config/config.dart';
import '../../../../../../http/data_utils.dart';
import '../../meeting_list_page/models/meeting_apply_list_model.dart';

class MeetingDetailPageController extends GetxController {
  bool isStar = false;
  int index = Get.arguments["index"];
  MeetingApplyResults itemData = Get.arguments["itemData"];

  List configMap = [];
  List configList = []; // 数据源
  List files = []; // 附件
  List meetingarrangementList = []; // 会议决议
  bool isHasFiles = false;

  String subUrl = "";
  Map<String, dynamic> subMap = {};

  @override
  void onInit() {
    super.onInit();
    getFormConfigWithChoicesKey();
    getArrangementListData();
  }

// 星标状态更改
  changeStarStatus() {
    isStar = !isStar;
    update();
  }

// 获取会议室的formConfig
  getFormConfigWithChoicesKey() {
    /// 3是预览，1是新增，2是查询
    DataUtils.getFormConfigId(2, '会议室申请', '&expand=model_config', null,
        success: (data) {
      if (data["code"] == 200) {
        Map datas = data["data"];
        List results = datas["results"];
        if (results.isNotEmpty) {
          subUrl = '${Config.severBaseUrl}${results[0]["model_config"]["url"]}';
          configMap.clear();
          configMap.addAll(results[0]["form_config"]);
          setModelsToNewData();
        }
        update();
      } else {
        ProgressHUD.showError(data["msg"]);
      }
    }, fail: (code) {});
  }

// 获取新的数据model
  setModelsToNewData() {
    List newData = [];
    configList.clear();
    isHasFiles = false;

    Map datas = itemData.toJson();
    configMap = moveFiledToBottom();
    for (Map element in configMap) {
      Map newMap = {};
      datas.forEach((key, value) {
        if (element["config"]["variable"] == key) {
          newMap["commonTitle"] = element["attrs"]["label"];
          // 附件处理
          if (key == "django_file") {
            if (value.isNotEmpty) {
              for (Map filesM in value) {
                isHasFiles = true;
                files.add(filesM);
              }
            }
          }

          // 针对数据结构分开处理；
          if (value is List) {
            List values = [];
            for (Map element in value) {
              values.add(element["choices_key"]);
            }
            newMap["commonValue"] = values.join(',');
          } else if (datas[key] is Map) {
            newMap["commonValue"] = datas[key]["choices_key"];
          } else {
            if (value.toString() == "null") {
              value = "无";
            }
            newMap["commonValue"] = value;
          }
          newMap["isHasFiles"] = isHasFiles;
          newData.add(newMap);
          isHasFiles = false;
        }
      });
    }
    configList.addAll(newData);
  }

  // 把附件放在最下面
  moveFiledToBottom() {
    List currentArr = copyWithList(configMap);
    List dataSource = [];
    List uploadArr = [];
    for (var i = 0; i < currentArr.length; i++) {
      Map item = currentArr[i];
      if (item["config"]["variable"] == "django_file") {
        uploadArr.add(item);
      } else {
        dataSource.add(item);
      }
      if (i == currentArr.length - 1 && uploadArr.isNotEmpty) {
        dataSource.insert(i, uploadArr[0]);
      }
    }
    return dataSource;
  }

  // 获取会议室的formConfig
  getFormConfigWithArrangement(context) {
    /// 3是预览，1是新增，2是查询
    DataUtils.getFormConfigId(0, '会议安排', '&expand=model_config', null,
        success: (data) {
      if (data["code"] == 200) {
        Map datas = data["data"];
        List results = datas["results"];

        navigateAndRefresh(context, 'flow-page', {
          "dataMap": results.first,
          "meetingId": itemData.id,
          "meetingName": itemData.meetingRoom!.choicesKey,
        });
      } else {
        ProgressHUD.showError(data["msg"]);
      }
      update();
    }, fail: (code) {});
  }

  void navigateAndRefresh(BuildContext context, url, argument) async {
    final result = await Get.toNamed('/$url', arguments: argument);
    // 可以做的操作
    if (result != null) {
      getArrangementListData();
    }
  }

  // 删除该条数据
  deleteItemWithId(id) {
    DataUtils.deleteItemWithId(Config.applyArrangementList, id, null,
        success: (data) {
      if (data["code"] == 200) {
        getArrangementListData();
      } else {
        ProgressHUD.showError(data["msg"]);
      }
    }, fail: (code) {});
  }

  // 获取会议决议数据
  getArrangementListData() {
    DataUtils.getApplyArrangementList(itemData.id, null, success: (data) {
      if (data["code"] == 200) {
        meetingarrangementList.clear();
        meetingarrangementList.addAll(data["data"]["results"]);
      } else {
        ProgressHUD.showError(data["msg"]);
      }
      update();
    }, fail: (code) {});
  }
}
