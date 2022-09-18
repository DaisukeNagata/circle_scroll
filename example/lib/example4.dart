import 'package:circle_scroll/circle_scroll_all_area_expansion.dart';
import 'package:circle_scroll_example/example5.dart';
import 'package:flutter/material.dart';

class Example4 extends StatelessWidget {
  const Example4({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExamplePage4();
  }
}

class ExamplePage4 extends StatefulWidget {
  const ExamplePage4({super.key});

  @override
  State<ExamplePage4> createState() => _ExampleState4();
}

class _ExampleState4 extends State<ExamplePage4> with TickerProviderStateMixin {
  var _tex = '';
  var _initial = 0.0;
  var _distance = 0.0;
  final double _addAngle = 0.25;
  List<double> angleAnimationList = [0.0, 0.0];

  final List<double> _valueList = [
    1,
    0.75,
    0.5,
    0.25,
  ];

  List<Offset> offSetList = [];
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
    var w = MediaQuery.of(context).size.width - 30;
    var h = MediaQuery.of(context).size.width - 30;

    Size size = Size(w, h);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('EverDaySoft'),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const Example5();
                  },
                ),
              );
            },
            icon: const Icon(Icons.arrow_forward_ios),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.topCenter,
            width: size.width + _widgetSize,
            child: Text(
              _tex,
              style: const TextStyle(color: Colors.white, fontSize: 30),
              textAlign: TextAlign.center,
            ),
          ),
          _def(
            EdgeInsets.zero,
            size,
            2,
            _valueList,
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
    EdgeInsetsGeometry edgeInset,
    Size size,
    double aliment,
    List<double> valueList,
  ) {
    return Container(
      alignment: Alignment.center,
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      margin: edgeInset,
      child: Stack(
        children: [
          Container(
            color: Colors.grey,
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
                    w: _abc(offSetList),
                    color: Colors.white,
                    height: size.width,
                    aliment: aliment,
                    size1Matrix: Size(_widgetSize, _widgetSize),
                    size2Matrix: Size(_widgetSize, _widgetSize),
                    sizeList: [
                      Size(size.width - _widgetSize, size.width - _widgetSize),
                      Size(size.width - _widgetSize, size.width - _widgetSize),
                      Size(size.width - _widgetSize, size.width - _widgetSize),
                    ],
                    valueList: valueList,
                    offSetList: offSetList,
                    animation: _animation,
                    callBack: (offsetValue) async {
                      if (offsetValue.length == 1) {
                        offSetList = offsetValue.first as List<Offset>;
                      } else {
                        setState(() {
                          offSetList = offsetValue.first as List<Offset>;
                          _tex = offsetValue.last.toString();
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
