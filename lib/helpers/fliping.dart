
import 'dart:math';

import 'package:flutter/material.dart';

class FlipWidget extends StatefulWidget {
  const FlipWidget({Key? key}) : super(key: key);

  @override
  State<FlipWidget> createState() => _FlipWidgetState();
}

// don't forget "with SingleTickerProviderStateMixin"
class _FlipWidgetState extends State<FlipWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  AnimationStatus _status = AnimationStatus.dismissed;

  // initialize _controller, _animation
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween(end: 1.0, begin: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _status = status;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kindacode.com'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              // Horizontal Flipping
              Transform(
                alignment: FractionalOffset.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0015)
                  ..rotateY(pi * _animation.value),
                child: Card(
                  child: _animation.value <= 0.5
                      ? Container(
                      color: Colors.deepOrange,
                      width: 240,
                      height: 300,
                      child: const Center(
                          child: Text(
                            '?',
                            style:
                            TextStyle(fontSize: 100, color: Colors.white),
                          )))
                      : Container(
                      width: 240,
                      height: 300,
                      color: Colors.grey,
                      child: Image.network(
                        'https://www.kindacode.com/wp-content/uploads/2021/09/girl.jpeg',
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              // Vertical Flipping
              const SizedBox(
                height: 30,
              ),
              // Transform(
              //   alignment: FractionalOffset.center,
              //   transform: Matrix4.identity()
              //     ..setEntry(3, 2, 0.0015)
              //     ..rotateX(pi * _animation.value),
              //   child: Card(
              //     child: _animation.value <= 0.5
              //         ? Container(
              //         color: Colors.deepPurple,
              //         width: 240,
              //         height: 300,
              //         child: const Center(
              //             child: Text(
              //               '?',
              //               style: TextStyle(fontSize: 100, color: Colors.white),
              //             )))
              //         : Container(
              //         width: 240,
              //         height: 300,
              //         color: Colors.grey,
              //         child: RotatedBox(
              //           quarterTurns: 2,
              //           child: Image.network(
              //             'https://www.kindacode.com/wp-content/uploads/2021/09/flower.jpeg',
              //             fit: BoxFit.cover,
              //           ),
              //         )),
              //   ),
              // ),
              ElevatedButton(
                  onPressed: () {
                    if (_status == AnimationStatus.dismissed) {
                      _controller.forward();
                    }
                    // else {
                    //                   _controller.reverse();
                    // }
                  },
                  child: const Text('Reveal The Secrets'))
            ],
          ),
        ),
      ),
    );
  }
}
