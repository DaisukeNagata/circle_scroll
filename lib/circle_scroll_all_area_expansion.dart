import 'package:circle_scroll/circle_scroll.dart';
import 'package:flutter/material.dart';

class CircleScrollAllAreaExpansion extends StatelessWidget {
  const CircleScrollAllAreaExpansion({
    super.key,
    required this.w,
    required this.color,
    required this.height,
    required this.aliment,
    required this.size1Matrix,
    required this.size2Matrix,
    required this.sizeList,
    required this.valueList,
    required this.offSetList,
    required this.animation,
    required this.callBack,
  });
  final Widget w;
  final Color color;
  final double height;
  final double aliment;
  final Size size1Matrix;
  final Size size2Matrix;
  final List<Size> sizeList;
  final List<double> valueList;
  final List<Offset> offSetList;
  final Animation<double> animation;
  final Function(List<dynamic>) callBack;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Align(
        alignment: Alignment(0, aliment),
        heightFactor: aliment / 2,
        widthFactor: 1,
        child: SizedBox(
          width: height + sizeList[0].width,
          height: height + sizeList[0].height,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                transform: Matrix4.translationValues(
                  size1Matrix.width,
                  size1Matrix.height,
                  0,
                ),
                width: sizeList[1].width,
                height: sizeList[1].height,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              ),
              Container(
                transform: Matrix4.translationValues(
                  size2Matrix.width,
                  size2Matrix.height,
                  0,
                ),
                width: sizeList[2].width,
                height: sizeList[2].height,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
                child: CustomPaint(
                  painter: CircleScroll(
                    valueList: valueList,
                    c: animation,
                    callBack: (off) async {
                      callBack.call([off]);
                    },
                  ),
                ),
              ),
              for (var i = 0; i < offSetList.length; i++)
                Container(
                  transform: Matrix4.translationValues(
                    size2Matrix.width / 2,
                    size2Matrix.height / 2,
                    0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      callBack.call([offSetList, i]);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: (offSetList[i].dy), left: (offSetList[i].dx)),
                      child: w,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
