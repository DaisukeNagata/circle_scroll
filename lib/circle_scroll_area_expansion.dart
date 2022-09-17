import 'package:circle_scroll/circle_scroll.dart';
import 'package:flutter/material.dart';

class CircleScrollAreaExpansion extends StatelessWidget {
  const CircleScrollAreaExpansion({
    super.key,
    required this.w,
    required this.color,
    required this.height,
    required this.aliment,
    required this.marginList,
    required this.valueList,
    required this.offSetList,
    required this.animation,
    required this.call,
  });
  final Widget w;
  final Color color;
  final double height;
  final double aliment;
  final List<double> marginList;
  final List<double> valueList;
  final List<Offset> offSetList;
  final Animation<double> animation;
  final Function(List<dynamic>) call;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Align(
        alignment: Alignment(0, aliment),
        heightFactor: aliment / 2,
        widthFactor: 1,
        child: SizedBox(
          width: height + marginList[1],
          height: height + marginList[1],
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                transform: Matrix4.translationValues(
                    (marginList.first * -1) / 2,
                    (marginList.first * -1) / 2,
                    0),
                width: height + marginList.first,
                height: height + marginList.first,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              ),
              Container(
                width: height,
                height: height,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: CustomPaint(
                  painter: CircleScroll(
                    valueList: valueList,
                    c: animation,
                    callBack: (off) async {
                      call.call([off]);
                    },
                  ),
                ),
              ),
              for (var i = 0; i < (offSetList.length); i++)
                Container(
                  transform: Matrix4.translationValues(
                      -marginList.last / 2, -marginList.last / 2, 0),
                  child: GestureDetector(
                    onTap: () {
                      call.call([offSetList, i]);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        top: (offSetList[i].dy),
                        left: (offSetList[i].dx),
                      ),
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
