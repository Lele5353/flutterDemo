import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutteroa/app/http/dio_utils.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../../component/common/progress_hud.dart';
import '../../../../../../http/data_utils.dart';
import '../../../model/notice_model.dart';

class NoticeDetailPageController extends GetxController {
  String titleString = Get.arguments["title"];
  Results itemData = Get.arguments["itemData"];
  List resultUrls = [];
  bool hasData = false;
  bool isLoading = true;
  String pdfFile = "";
  bool isShowPdf = true;

  @override
  void onInit() {
    super.onInit();
    getFiles();
  }

  @override
  void onReady() {
    super.onReady();
    // 判断如果是未读，再请求接口
    if (!itemData.isRead!) {
      readNoticeToServer(itemData.id);
    }
  }

// 暂时先只加载一个，多个附件的情况暂时没法处理
  getFiles() {
    if (itemData.djangoFile!.isNotEmpty) {
      getfilesData(itemData.djangoFile![0]);
    } else {
      hasData = false;
    }
  }

  // 获取附件
  getfilesData(id) {
    DataUtils.getFiles(id, null, success: (data) {
      if (data["code"] == 200) {
        Map datas = data["data"];
        resultUrls.add(datas);
        String file = datas["file"];
        String name = file.substring(file.lastIndexOf("/") + 1, file.length);
        String suffix = name.substring(name.lastIndexOf(".") + 1, name.length);
        if (suffix.contains("pdf")) {
          createFileOfPdfUrl(datas["file"]).then((f) {
            pdfFile = f.path;
            hasData = true;
            isShowPdf = true;
            isLoading = false;
            update();
          }).onError((error, stackTrace) {
            hasData = false;
            isLoading = false;
            update();
          });
        } else if (suffix.contains("jpg") || suffix.contains("png")) {
          pdfFile = datas["file"];
          hasData = true;
          isShowPdf = false;
          isLoading = false;
          update();
        } else {
          isLoading = false;
          hasData = false;
          update();
        }
      } else {
        isLoading = false;
        update();
        ProgressHUD.showError(data["msg"]);
      }
    }, fail: (code) {});
  }

  // 已读公告
  readNoticeToServer(id) {
    DataUtils.readAnnouncementToServer(Method.put, {"id": id}, success: (data) {
      if (data["code"] == 200) {
      } else {
        ProgressHUD.showError(data["msg"]);
      }
    }, fail: (code) {});
  }

  // 下载pdf文件
  Future<File> createFileOfPdfUrl(url) async {
    Completer<File> completer = Completer();
    try {
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      // print("Download files");
      // print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }
}
