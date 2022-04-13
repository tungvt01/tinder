import 'dart:async';
import 'dart:math';

import 'package:rxdart/subjects.dart';
import 'package:tinder/presentation/base/base_page_mixin.dart';

enum SwipCardTriggerDirecton {
  left,
  right,
}

class SwipeCardController {
  final PublishSubject<SwipCardTriggerDirecton> _trigger =
      PublishSubject<SwipCardTriggerDirecton>();
  executeSwipe({required SwipCardTriggerDirecton directon}) {
    _trigger.add(directon);
  }

  Stream<SwipCardTriggerDirecton> get swipeEventStream => _trigger.stream;
}

class SwipeCardWidget extends StatefulWidget {
  final Widget child;
  final Function(bool)? onCardRemove;
  final SwipeCardController? controller;

  const SwipeCardWidget({
    Key? key,
    required this.child,
    this.onCardRemove,
    this.controller,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SwipeCardWidgetState();
}

class _SwipeCardWidgetState extends State<SwipeCardWidget>
    with TickerProviderStateMixin {
  Offset? _startDragOffset;
  double _rotateRadian = 0.0;
  double _rotateDegree = 0.0;
  late final AnimationController _animationController;

  late Animation<double> _rotateAnimation;
  StreamSubscription<SwipCardTriggerDirecton>? _subscription;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _rotateAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    _subscription?.cancel();
    _subscription = widget.controller?.swipeEventStream.listen((event) {
      final endRadian = event == SwipCardTriggerDirecton.left ? -pi : pi;
      _animateRotation(
          beginRadian: 0.0,
          endRadian: endRadian,
          isSwipeLeft: event == SwipCardTriggerDirecton.left,
          actionWhenCompleted: widget.onCardRemove);
    });

    return GestureDetector(
      onHorizontalDragStart: (details) {
        _startDragOffset = details.globalPosition;
        _rotateRadian = 0.0;
        _rotateDegree = 0.0;
      },
      onHorizontalDragEnd: (_) async {
        _startDragOffset = null;
        if (_rotateDegree.abs() < 45 / 2) {
          _animateRotation(beginRadian: _rotateRadian, endRadian: 0.0);
        } else {
          final endRotateRadian = _rotateDegree < 0 ? -pi : pi;
          await _animateRotation(
              beginRadian: _rotateRadian,
              endRadian: endRotateRadian,
              isSwipeLeft: _rotateDegree < 0,
              actionWhenCompleted: widget.onCardRemove);
        }
        setState(() {});
      },
      onHorizontalDragUpdate: (details) {
        final maxDistance = MediaQuery.of(context).size.width / 2;
        const maxRotationAngle = 45; // degree
        final diffMove = details.globalPosition.dx - _startDragOffset!.dx;
        _rotateDegree = diffMove / maxDistance * maxRotationAngle;
        setState(() {
          _rotateRadian = _rotateDegree * pi / 180;
        });
      },
      child: Transform(
        transform: Matrix4.rotationZ(_rotateRadian),
        alignment: FractionalOffset.bottomCenter,
        child: widget.child,
      ),
    );
  }

  _animateRotation(
      {required double beginRadian,
      required double endRadian,
      bool isSwipeLeft = true,
      Function(bool)? actionWhenCompleted}) async {
    _rotateAnimation.removeListener(_updateRotationDegree);

    _rotateAnimation = Tween<double>(
      begin: beginRadian,
      end: endRadian,
    ).animate(_animationController);

    _animationController.forward(from: beginRadian).whenComplete(() {
      if (actionWhenCompleted != null) {
        actionWhenCompleted(isSwipeLeft);
      }
    });
    _rotateAnimation.addListener(_updateRotationDegree);
  }

  _updateRotationDegree() {
    setState(() {
      _rotateRadian = _rotateAnimation.value;
    });
  }

  @override
  dispose() {
    _animationController.dispose();
    _subscription?.cancel();
    super.dispose();
  }
}
