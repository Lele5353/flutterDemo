import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../component/common/screen_adapter.dart';
import '../../model/notice_model.dart';
import '../controllers/work_controller.dart';
import '../widgets/big_title_widget_view.dart';

class NoticeView extends GetView<WorkController> {
  final String titleText;
  const NoticeView({
    Key? key,
    required this.titleText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(
            ScreenAdapter.width(20), 0, ScreenAdapter.width(20), 0),
        child: _buildCardView(context));
  }

  Widget _buildCardView(context) {
    return Card(
      color: Colors.white,
      //shape 设置边，可以设置圆角
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      // clipBehavior: Clip.antiAlias, // 设置抗锯齿
      elevation: 0.0, // 设置阴影大小
      child: Column(children: [
        // 标题
        _buildTopView(context),
        // 列表
        _buildListView(context)
      ]),
    );
  }

// 标题
  Widget _buildTopView(context) {
    return Row(
      children: [
        BigTitleWidgetView(
          title: titleText,
        ),
        const Spacer(),
        IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              // 列表页
              // Get.toNamed('/notice-list-page');
              controller.backAndRefreshNotice(
                  context, '/notice-list-page', null);
            },
            icon: const Icon(
              Icons.keyboard_double_arrow_right_rounded,
              color: Colors.blue,
            ))
      ],
    );
  }

// 列表
  Widget _buildListView(context) {
    return Container(
        padding: EdgeInsets.fromLTRB(
            ScreenAdapter.width(20), 0, ScreenAdapter.width(0), 0),
        child: MediaQuery.removePadding(
            //解决ListView顶部留白的问题
            context: context,
            removeTop: true,
            child: GetBuilder<WorkController>(builder: (controller) {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    Results model = controller.noticeList[index];
                    String typeS = controller.getAnnouncemenType(model.type!);
                    return InkWell(
                      onTap: () {
                        // 单个详情页面
                        controller.backAndRefreshNotice(
                            context,
                            '/notice-detail-page',
                            {"title": model.title, "itemData": model});
                        // Get.toNamed('/notice-detail-page', arguments: {
                        //   "title": model.title,
                        //   "itemData": model
                        // });
                      },
                      child: Row(
                        children: [
                          Offstage(
                            offstage: model.isRead!,
                            child: const Badge(),
                          ),
                          SizedBox(
                            width: ScreenAdapter.screenWidth() / 1.5,
                            child: Text(
                              '【$typeS】${model.title!}',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                              splashColor: Colors.white,
                              onPressed: () {
                                Get.toNamed('/notice-detail-page', arguments: {
                                  "title": model.title!,
                                });
                              },
                              icon: const Icon(
                                Icons.arrow_circle_right_outlined,
                                color: Colors.lightBlueAccent,
                              ))
                        ],
                      ),
                    );
                  },
                  itemCount: controller.noticeList.length);
            })));
  }
}
