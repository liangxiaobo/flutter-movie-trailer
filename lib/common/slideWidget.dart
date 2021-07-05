import 'package:flutter/cupertino.dart';

class SlideWidget extends StatefulWidget {
  final bool show;
  final Widget child;

  SlideWidget({Key? key, required this.show, required this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SlideWidetState();
}

class _SlideWidetState extends State<SlideWidget> with TickerProviderStateMixin{
  late AnimationController _controller;
  late Tween<Offset> _tween;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _tween = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset(0.0, 0.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.show) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    
//    Size screenSize = MediaQuery.of(context).size;
    return SlideTransition(
      position: _tween.animate(_controller),
      child: widget.child,
    );
  }

}