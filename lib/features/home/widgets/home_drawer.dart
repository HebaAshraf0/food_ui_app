import 'package:flutter/material.dart';
import 'package:food_ui_app/design_system/colors.dart';
import 'package:food_ui_app/features/home/widgets/my_home_drawer.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key, required this.child});
  final Widget child;

  @override
  State<HomeDrawer> createState() => HomeDrawerState();
  static HomeDrawerState? of(BuildContext context) =>
      context.findAncestorStateOfType<HomeDrawerState>();
}

class HomeDrawerState extends State<HomeDrawer>
    with SingleTickerProviderStateMixin {
  static const Duration toggleDuration = Duration(milliseconds: 250);
  static const double maxSlide = 225;
  static const double minDragStartEdge = 60;
  static const double maxDragStartEdge = maxSlide - 16;
  AnimationController? _animationController;
  bool _canBeDragged = false;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: toggleDuration,
    );
    super.initState();
  }

  void close() => _animationController?.reverse();

  void open() => _animationController?.forward();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      child: AnimatedBuilder(
        builder: (context, child) {
          double animValue = _animationController?.value ?? 0;
          final slideAmount = maxSlide * animValue;
          final contentScale = 1.0 - (0.3 * animValue);
          return Stack(
            children: [
              MyHomeDrawer(
                isAnimating: _animationController!.isForwardOrCompleted,
              ),
              Container(
                decoration: BoxDecoration(
                  color: ColorsModel.lightOrange.withOpacity(0.3),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                transformAlignment: Alignment.centerLeft,
                transform: Matrix4.identity()
                  ..translate(slideAmount - 50)
                  ..scale(contentScale, contentScale + 0.1),
              ),
              Container(
                decoration: BoxDecoration(
                  color: ColorsModel.lightOrange.withOpacity(0.3),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                clipBehavior: !_animationController!.isDismissed
                    ? Clip.antiAlias
                    : Clip.none,
                transform: Matrix4.identity()
                  ..translate(slideAmount)
                  ..scale(contentScale, contentScale),
                transformAlignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: _animationController!.isCompleted ? close : null,
                  child: child,
                ),
              )
            ],
          );
        },
        animation: _animationController!,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = _animationController!.isDismissed &&
        details.globalPosition.dx < minDragStartEdge;
    bool isDragCloseFromRight = _animationController!.isCompleted &&
        details.globalPosition.dx > maxDragStartEdge;

    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta! / maxSlide;
      _animationController?.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    double _kMinFlingVelocity = 365.0;

    if (_animationController!.isDismissed ||
        _animationController!.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      _animationController!.fling(velocity: visualVelocity);
    } else if (_animationController!.value < 0.5) {
      close();
    } else {
      open();
    }
  }
}
