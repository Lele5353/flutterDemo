import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../../component/common/screen_adapter.dart';
import '../../../../../../component/common_widgets/gap.dart';
import '../../../model/notice_model.dart';
import '../controllers/notice_list_page_controller.dart';

class NoticeListView extends StatefulWidget {
  const NoticeListView({
    Key? key,
  }) : super(key: key);

  @override
  State<NoticeListView> createState() => _NoticeListViewState();
}

class _NoticeListViewState extends State<NoticeListView> {
  final NoticeListPageController controller =
      Get.put(NoticeListPageController());
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
          controller.getAnnouncementListData(controller.tabController.index);
        },
        onLoading: () async {
          await Future.delayed(const Duration(milliseconds: 1000));
          if (controller.hasMore) {
            controller.pageIndex++;
            controller.getAnnouncementListData(controller.tabController.index);
            refreshController.loadComplete();
          } else {
            refreshController.loadNoData();
          }
        },
        child: GetBuilder<NoticeListPageController>(builder: (controller) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              Results model = controller.noticeList[index];
              String typeS = controller.getAnnouncemenType(model.type!);
              return InkWell(
                onTap: () {
                  controller.backAndRefreshNotice(context, 'notice-detail-page',
                      {"title": model.title, "itemData": model});
                },
                child: Container(
                    padding: EdgeInsets.fromLTRB(
                        ScreenAdapter.width(20), 0, ScreenAdapter.width(20), 0),
                    child: Card(
                      elevation: 0,
                      color: Colors.white,
                      //shape 设置边，可以设置圆角
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      // clipBehavior: Clip.antiAlias, // 设置抗锯齿
                      child: Container(
                          height: ScreenAdapter.screenHeight() / 12,
                          padding: EdgeInsets.only(
                            left: ScreenAdapter.width(20),
                            right: ScreenAdapter.width(20),
                          ),
                          child: Row(
                            children: [
                              Gap.w5,
                              CircleAvatar(
                                radius: 3,
                                backgroundColor:
                                    !model.isRead! ? Colors.red : Colors.green,
                              ),
                              Gap.w5,
                              Expanded(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '【$typeS】${model.title!}',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: ScreenAdapter.fontSize(28)),
                                  ),
                                  Gap.h5,
                                  Text(
                                    "  ${model.updateTime!} ",
                                    style: TextStyle(
                                        fontSize: ScreenAdapter.fontSize(26),
                                        color: Colors.black.withAlpha(95)),
                                  )
                                ],
                              ))
                            ],
                          )),
                    )),
              );
            },
            itemCount: controller.noticeList.length,
          );
        }));
  }
}
