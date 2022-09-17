import 'package:circle_scroll/circle_scroll_all_area_expansion.dart';
import 'package:flutter/material.dart';

class Example3 extends StatelessWidget {
  const Example3({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExamplePage3();
  }
}

class ExamplePage3 extends StatefulWidget {
  const ExamplePage3({super.key});

  @override
  State<ExamplePage3> createState() => _ExampleState3();
}

class _ExampleState3 extends State<ExamplePage3> with TickerProviderStateMixin {
  var _tex = '';
  var _initial = 0.0;
  var _distance = 0.0;
  final double _addAngle = 0.25;
  List<double> angleAnimationList = [0.0, 0.0];
  final List<double> _valueList = [
    1,
    0.25,
    0.5,
  ];

  final List<double> _valueList2 = [
    1,
    0.75,
    0.5,
  ];

  List<Offset> offSetList = [];
  List<Offset> offSetList2 = [];
  late AnimationController c;

  late Animation<double> _animation;

  final _widgetSize = 30.0;
  final animationValue = 500;

  @override
  void initState() {
    super.initState();
    c = AnimationController(vsync: this)
      ..duration = Duration(milliseconds: animationValue)
      ..addListener(() {
        setState(() {
          if (c.isCompleted) {
            c.stop();
          }
        });
      })
      ..forward();
    _animation = Tween(
      begin: 0.0,
      end: 0.0,
    ).animate(c);
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width / 2;
    var h = MediaQuery.of(context).size.width / 2;
    var t = TransformationController();
    t.value = TransformationController().value = Matrix4.identity()
      ..translate(-w / 1.5, 0);
    var t2 = TransformationController();
    t2.value = TransformationController().value = Matrix4.identity()
      ..translate(w * 1.35, 0);

    Size size = Size(w, h);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('EverDaySoft'),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.topCenter,
            width: size.width * 2,
            child: Text(
              _tex,
              style: const TextStyle(color: Colors.white, fontSize: 30),
              textAlign: TextAlign.center,
            ),
          ),
          _def(
            t,
            const EdgeInsets.only(
              top: 50,
            ),
            size,
            2,
            _widgetSize / 2,
            _valueList,
          ),
          _def(
            t2,
            EdgeInsets.only(
              top: size.height * 1.5,
            ),
            size,
            2,
            _widgetSize / 2,
            _valueList2,
          ),
        ],
      ),
    );
  }

  Widget _abc(List<Offset> offsetList) {
    return Container(
      width: _widgetSize,
      height: _widgetSize,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
      ),
    );
  }

  Widget _def(
    TransformationController t,
    EdgeInsetsGeometry edgeInset,
    Size size,
    double aliment,
    double margin,
    List<double> valueList,
  ) {
    return Container(
      color: Colors.transparent,
      height: MediaQuery.of(context).size.width / 1.5,
      width: MediaQuery.of(context).size.width,
      margin: edgeInset,
      child: Stack(
        children: [
          Container(
            color: Colors.grey,
            child: InteractiveViewer(
              constrained: false,
              panEnabled: false,
              transformationController: t,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onPanStart: (DragStartDetails details) {
                  setState(() {
                    _initial = details.globalPosition.dx;
                  });
                },
                onPanUpdate: (details) {
                  setState(() {
                    _distance = details.globalPosition.dx - _initial;
                  });
                },
                onPanEnd: (DragEndDetails details) {
                  setState(() {
                    _initial = 0.0;
                    switch (_distance.isNegative) {
                      case false:
                        angleAnimationList = [
                          angleAnimationList.last,
                          angleAnimationList.last - _addAngle
                        ];
                        break;
                      case true:
                        angleAnimationList = [
                          angleAnimationList.last,
                          angleAnimationList.last + _addAngle
                        ];
                        break;
                    }
                    _animation = Tween(
                      begin: angleAnimationList.first,
                      end: angleAnimationList.last,
                    ).chain(CurveTween(curve: Curves.easeInOut)).animate(c);
                    c
                      ..reset()
                      ..forward();
                  });
                },
                child: Stack(
                  children: [
                    CircleScrollAllAreaExpansion(
                      w: valueList[1] == 0.25
                          ? _abc(offSetList)
                          : _abc(offSetList2),
                      color: Colors.white,
                      height: size.width,
                      aliment: aliment,
                      size1Matrix: Size(_widgetSize, _widgetSize),
                      size2Matrix: Size(_widgetSize, _widgetSize),
                      sizeList: [
                        Size(_widgetSize * 3, _widgetSize * 3),
                        Size(size.width, size.width),
                        Size(size.width, size.width),
                      ],
                      valueList: valueList[1] == 0.25 ? valueList : _valueList2,
                      offSetList:
                          valueList[1] == 0.25 ? offSetList : offSetList2,
                      animation: _animation,
                      call: (offsetValue) async {
                        if (offsetValue.length == 1) {
                          if (valueList[1] == 0.25) {
                            offSetList = offsetValue.first as List<Offset>;
                          } else {
                            offSetList2 = offsetValue.first as List<Offset>;
                          }
                        } else {
                          setState(() {
                            if (valueList[1] == 0.25) {
                              offSetList = offsetValue.first as List<Offset>;
                            } else {
                              offSetList2 = offsetValue.first as List<Offset>;
                            }
                            _tex = offsetValue.last.toString();
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
