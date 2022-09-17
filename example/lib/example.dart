import 'package:circle_scroll/circle_scroll_area_expansion.dart';
import 'package:circle_scroll_example/example2.dart';
import 'package:flutter/material.dart';

enum CircleType {
  one,
  two,
  three,
  four,
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExamplePage();
  }
}

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExampleState();
}

class _ExampleState extends State<ExamplePage> with TickerProviderStateMixin {
  var _tex = '';
  var _initial = 0.0;
  var _distance = 0.0;
  final double _addAngle = 0.05;
  List<double> angleAnimationList = [0.0, 0.0];
  final List<double> _valueList = [
    0.4,
    0.45,
    0.5,
    0.55,
    0.6,
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
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    var t = TransformationController();
    t.value = TransformationController().value = Matrix4.identity()
      ..translate(-((h - w) / 2), -h / 2);

    Size size = Size(w, h);
    return Scaffold(
      backgroundColor: const Color(0xFF616161),
      appBar: AppBar(
        title: const Text('EverDaySoft'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const Example2();
                  },
                ),
              );
            },
            icon: const Icon(Icons.arrow_forward_ios),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.topCenter,
            width: size.width,
            child: Text(
              _tex,
              style: const TextStyle(color: Colors.white, fontSize: 30),
              textAlign: TextAlign.center,
            ),
          ),
          _def(
            CircleType.one,
            t,
            EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.07,
            ),
            size,
            1.3,
            _widgetSize / 2,
            _valueList,
          ),
          _def(
            CircleType.two,
            t,
            EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.25,
            ),
            size,
            1.3,
            _widgetSize / 2,
            _valueList,
          ),
          _def(
            CircleType.three,
            t,
            EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.45,
            ),
            size,
            1.3,
            _widgetSize / 2,
            _valueList,
          ),
          _def(
            CircleType.four,
            t,
            EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.65,
            ),
            size,
            1.3,
            _widgetSize / 2,
            _valueList,
          ),
        ],
      ),
    );
  }

  Widget _abc(List<Offset> offsetList) {
    return Container(
      margin: const EdgeInsets.only(right: 0),
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
      ),
    );
  }

  Widget _def(
    CircleType type,
    TransformationController t,
    EdgeInsetsGeometry edgeInset,
    Size size,
    double aliment,
    double margin,
    List<double> valueList,
  ) {
    return Container(
      color: Colors.black,
      height: MediaQuery.of(context).size.height / 6,
      width: size.width,
      margin: edgeInset,
      child: Stack(
        children: [
          InteractiveViewer(
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
                  ).chain(CurveTween(curve: Curves.easeInOutCirc)).animate(c);
                  c
                    ..reset()
                    ..forward();
                });
              },
              child: Stack(
                children: [
                  CircleScrollAreaExpansion(
                    w: _abc(offSetList),
                    color: Colors.white,
                    height: size.height,
                    aliment: aliment,
                    marginList: typeList(type),
                    valueList: valueList,
                    offSetList: offSetList,
                    animation: _animation,
                    call: (offsetValue) async {
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

  List<double> typeList(CircleType type) {
    if (type == CircleType.one) {
      return [-_widgetSize, _widgetSize, _widgetSize];
    } else if (type == CircleType.two) {
      return [0, _widgetSize, _widgetSize];
    } else if (type == CircleType.three) {
      return [_widgetSize, _widgetSize, _widgetSize];
    } else if (type == CircleType.four) {
      return [_widgetSize * 2, _widgetSize * 2, _widgetSize];
    }
    return [];
  }
}
