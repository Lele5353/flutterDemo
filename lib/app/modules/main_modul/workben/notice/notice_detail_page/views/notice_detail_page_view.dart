// import 'package:file_preview/file_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';

import '../../../../../../component/common/color_untils.dart';
// import '../../../../../../component/common/progress_hud.dart';
import '../../../../../../component/common/screen_adapter.dart';
// import '../../../../../../component/common_widgets/common_file_display.dart';
import '../../../../../../component/common_widgets/common_navi_widget.dart';
import '../../../../../../component/common_widgets/gap.dart';
import '../controllers/notice_detail_page_controller.dart';

class NoticeDetailPageView extends GetView<NoticeDetailPageController> {
  const NoticeDetailPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: commonAppNaviBar(context, "详情", 1, true, backCallBack: () {
          Get.back(result: 'refreshHome');
        }),
        body: WillPopScope(
            child: Container(
              // color: Colors.red,
              width: ScreenAdapter.screenWidth(),
              padding: EdgeInsets.fromLTRB(ScreenAdapter.width(60),
                  ScreenAdapter.height(20), ScreenAdapter.width(60), 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      controller.titleString,
                      style: TextStyle(
                          fontSize: ScreenAdapter.fontSize(32),
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Gap.h10,
                  Text(
                    "发布部门: ${controller.itemData.issuedOrg}",
                    style: TextStyle(
                        color: ColorUtils.comTitleColor,
                        fontSize: ScreenAdapter.fontSize(26)),
                  ),
                  Gap.h5,
                  Text(
                    "发布时间: ${controller.itemData.createTime}",
                    style: TextStyle(
                        color: ColorUtils.comTitleColor,
                        fontSize: ScreenAdapter.fontSize(26)),
                  ),
                  Gap.h5,
                  GetBuilder<NoticeDetailPageController>(builder: (controller) {
                    return controller.isLoading
                        ? SizedBox(
                            height: ScreenAdapter.screenHeight() / 2,
                            child: const Center(
                                child: CircularProgressIndicator()),
                          )
                        : controller.hasData
                            ? Expanded(
                                // child: FilePreviewWidget(
                                //   controller: FilePreviewController(),
                                //   width: ScreenAdapter.screenWidth(),
                                //   height: ScreenAdapter.screenHeight(),
                                //   path: controller.resultUrls[0]["file"],
                                //   callBack: FilePreviewCallBack(
                                //       onShow: () {},
                                //       onDownload: (progress) {},
                                //       onFail: (code, msg) {
                                //         ProgressHUD.showError("文件打开失败");
                                //       }),
                                // ),
                                child: pdfOrImageWidget(controller.isShowPdf))
                            : SizedBox(
                                height: ScreenAdapter.screenHeight() / 2,
                                child: const Center(child: Text("打开文件失败")),
                              );
                  }),
                  Gap.h5,
                ],
              ),
            ),
            onWillPop: () async {
              Get.back(result: 'refreshHome');
              return false;
            }));
  }

  Widget pdfOrImageWidget(isShow) {
    return isShow
        ? PDFView(
            filePath: controller.pdfFile,
            enableSwipe: true,
            swipeHorizontal: false,
            autoSpacing: false,
            pageFling: true,
            pageSnap: true,
            defaultPage: 0,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation: false,
          )
        : Image.network(
            controller.pdfFile,
            fit: BoxFit.contain,
          );
  }
}
