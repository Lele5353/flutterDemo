import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../../component/common/screen_adapter.dart';
import '../controllers/meeting_select_person_controller.dart';

class MeetingRefreshListView extends StatefulWidget {
  const MeetingRefreshListView({
    Key? key,
  }) : super(key: key);

  @override
  State<MeetingRefreshListView> createState() => _NoticeListViewState();
}

class _NoticeListViewState extends State<MeetingRefreshListView> {
  final MeetingSelectPersonController controller =
      Get.put(MeetingSelectPersonController());
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
        enablePullDown: false,
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
        onLoading: () async {
          await Future.delayed(const Duration(milliseconds: 1000));
          if (controller.source != 0) {
            if (controller.hasMore) {
              controller.pageIndex++;
              refreshController.loadComplete();
            } else {
              refreshController.loadNoData();
            }
            controller.getModelConfigOfIdData();
          } else {
            refreshController.loadNoData();
          }
        },
        child: GetBuilder<MeetingSelectPersonController>(builder: (controller) {
          if (controller.personList.isEmpty) {
            return Container(
              width: 100,
              height: 100,
              color: Colors.transparent,
              child: const Center(
                child: SizedBox(
                  width: 30.0,
                  height: 30.0,
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
          return _buildPersonsListWidget(controller);
        }));
  }

  // 人员选择列表
  Widget _buildPersonsListWidget(controller) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
      itemBuilder: (_, index) {
        Map itemInfo = controller.personList[index];
        bool status = itemInfo["status"];
        return GetBuilder<MeetingSelectPersonController>(builder: (controller) {
          return InkWell(
            onTap: () {
              status = !status;
              controller.changeSelectStatus(itemInfo, status);
            },
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: ScreenAdapter.height(1)),
              child: ListTile(
                leading: IconButton(
                    onPressed: () {
                      status = !status;
                      controller.changeSelectStatus(itemInfo, status);
                    },
                    icon: Icon(
                      status ? Icons.check_circle_sharp : Icons.circle_outlined,
                      color:
                          status ? Colors.green : Colors.black.withOpacity(0.3),
                    )),
                title: Text(
                  '${itemInfo["name"]}',
                  style: TextStyle(fontSize: ScreenAdapter.fontSize(30)),
                ),
              ),
            ),
          );
        });
      },
      itemCount: controller.personList.length,
    );
  }
}
