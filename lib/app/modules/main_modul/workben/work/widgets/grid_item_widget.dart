// 控制台模块网格状布局中每个item的设置

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutteroa/app/store/iconify_ep.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ep.dart';

import '../../../../../component/common/others.dart';
import '../../../../../component/common/screen_adapter.dart';

class GridItemWidget extends StatelessWidget {
  final Color bgColor;
  final String image;
  final double itemH;
  final bool isMore;
  final bool isSvg;
  const GridItemWidget({
    Key? key,
    required this.bgColor,
    required this.image,
    required this.itemH,
    this.isMore = false,
    this.isSvg = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic content = Ep.menu;
    return FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('imgs/fonts/iconfont.json'),
        builder: ((context, snapshot) {
          if (image.contains("iconfont")) {
            List imgs = image.split(" ");
            var map = json.decode(snapshot.data.toString());
            if (snapshot.connectionState == ConnectionState.done) {
              List icons =
                  List<IconModel>.from(map["glyphs"].map((icon) => IconModel(
                        name: "icon-${icon['font_class']}",
                        codePoint: icon['unicode_decimal'],
                      )));
              for (var element in icons) {
                if (element.name == imgs.last) {
                  content = element.codePoint;
                }
              }
              if (content is! int) {
                content = Ep.menu;
              }
            }
          } else {
            var icon = image.replaceAll("i-ep-", "");
            icon = icon.contains("-") ? icon.replaceAll("-", "_") : icon;
            if (IconifyEp.iconsList.containsKey(icon.toLowerCase())) {
              content = IconifyEp.iconsList[icon.toLowerCase()];
            } else {
              content = Ep.menu;
            }
          }

          // 需要接入外部图片库的widget
          Widget child = (content is int)
              ? Icon(
                  IconData(content, fontFamily: 'IconFontIcons'),
                  color: Colors.grey.shade800,
                )
              : Iconify(
                  content,
                  color: Colors.grey.shade800,
                );

          return isMore
              ? Container(
                  height: ScreenAdapter.height(itemH),
                  decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Container(
                    margin: EdgeInsets.all(
                        ScreenAdapter.width(itemH / 6)), // 控制图片大小
                    child: !isSvg
                        ? Image.asset(
                            image,
                            fit: BoxFit.contain,
                            color: Colors.grey.shade800,
                          )
                        : Iconify(
                            image,
                            color: Colors.grey.shade800,
                          ),
                  ),
                )
              : SizedBox(
                  height: ScreenAdapter.height(itemH),
                  child: !isSvg
                      ? Image.asset(
                          image,
                          fit: BoxFit.contain,
                          color: Colors.grey.shade800,
                        )
                      : child);
        }));
  }
}
