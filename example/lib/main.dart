import 'package:circle_scroll/circle_scroll_area_expansion.dart';
import 'package:circle_scroll_example/example.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
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
  final List<double> _valueList2 = [
    0.9,
    0.95,
    0.0,
    0.05,
    0.1,
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
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    var t = TransformationController();
    t.value = TransformationController().value = Matrix4.identity()
      ..translate(-((h - w) / 2), 0);

    var t2 = TransformationController();
    t2.value = TransformationController().value = Matrix4.identity()
      ..translate(-((h - w) / 2), -h / 3);

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
                    return const Example();
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
            true,
            t,
            EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.1,
            ),
            size,
            2.1,
            _widgetSize / 2,
            _valueList2,
          ),
          _def(
            false,
            t2,
            EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.5,
            ),
            size,
            1,
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
    bool flg,
    TransformationController t,
    EdgeInsetsGeometry edgeInset,
    Size size,
    double aliment,
    double margin,
    List<double> valueList,
  ) {
    return Container(
      color: Colors.black,
      width: size.width,
      height: MediaQuery.of(context).size.height / 4,
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
                  ).chain(CurveTween(curve: Curves.slowMiddle)).animate(c);
                  c
                    ..duration = Duration(milliseconds: animationValue)
                    ..reset()
                    ..forward();
                });
              },
              child: Stack(
                children: [
                  CircleScrollAreaExpansion(
                    w: flg ? _abc(offSetList) : _abc(offSetList2),
                    color: Colors.white,
                    height: size.height,
                    aliment: aliment,
                    marginList: flg
                        ? [-_widgetSize, _widgetSize, _widgetSize]
                        : [_widgetSize, _widgetSize, _widgetSize],
                    valueList: valueList,
                    offSetList: flg ? offSetList : offSetList2,
                    animation: _animation,
                    call: (offsetValue) async {
                      if (offsetValue.length == 1) {
                        if (flg) {
                          offSetList = offsetValue.first as List<Offset>;
                        } else {
                          offSetList2 = offsetValue.first as List<Offset>;
                        }
                      } else {
                        setState(() {
                          if (flg) {
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
        ],
      ),
    );
  }
}
