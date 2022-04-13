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
  final Function(SwipCardTriggerDirecton, double)? onDragUpdate;
  final Function()? onDragEnd;

  const SwipeCardWidget({
    Key? key,
    required this.child,
    this.onCardRemove,
    this.controller,
    this.onDragUpdate,
    this.onDragEnd,
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
  Color _coverLayerColor = Colors.transparent;

  final maxRotationAngle = 45;

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
        if (_rotateDegree.abs() < maxRotationAngle / 2) {
          _animateRotation(
            beginRadian: _rotateRadian,
            endRadian: 0.0,
          );
          _updateCoverLayerColerWhenSwiping(0);
        } else {
          final endRotateRadian = _rotateDegree < 0 ? -pi : pi;
          await _animateRotation(
              beginRadian: _rotateRadian,
              endRadian: endRotateRadian,
              isSwipeLeft: _rotateDegree < 0,
              actionWhenCompleted: widget.onCardRemove);
        }
        if (widget.onDragEnd != null) {
          widget.onDragEnd!();
        }
      },
      onHorizontalDragUpdate: (details) {
        final maxDistance = MediaQuery.of(context).size.width / 2;
        final diffMove = details.globalPosition.dx - _startDragOffset!.dx;
        _rotateDegree = diffMove / maxDistance * maxRotationAngle;
        setState(() {
          _rotateRadian = _rotateDegree * pi / 180;
        });
        _updateCoverLayerColerWhenSwiping(_rotateDegree);
        if (widget.onDragUpdate != null) {
          final fraction = _rotateDegree / maxRotationAngle;
          widget.onDragUpdate!(
              _rotateDegree <= 0
                  ? SwipCardTriggerDirecton.left
                  : SwipCardTriggerDirecton.right,
              fraction.abs());
        }
      },
      child: Transform(
        transform: Matrix4.rotationZ(_rotateRadian),
        alignment:
            FractionalOffset.bottomCenter.add(const FractionalOffset(0, 0.3)),
        child: Stack(
          children: [
            Positioned.fill(child: widget.child),
            Positioned.fill(
                child: Container(
              color: _coverLayerColor,
            )),
          ],
        ),
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

  _updateCoverLayerColerWhenSwiping(double rotateDegree) {
    bool isSwipeLeft = rotateDegree <= 0;
    const maxAlpha = 255;
    int alpha = (rotateDegree.abs() / maxRotationAngle * maxAlpha).toInt();
    setState(() {
      _coverLayerColor = (isSwipeLeft ? AppColors.primaryColor : Colors.white)
          .withAlpha(alpha);
    });
  }

  @override
  dispose() {
    _animationController.dispose();
    _subscription?.cancel();
    super.dispose();
  }
}
