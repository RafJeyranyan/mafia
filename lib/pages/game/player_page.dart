import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mafia/providers/player_provider.dart';
import 'package:provider/provider.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({Key? key}) : super(key: key);

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage>
    with SingleTickerProviderStateMixin {
  String? imageURL;
  bool isTaped = false;
  late AnimationController _controller;
  late Animation _animation;
  AnimationStatus _status = AnimationStatus.dismissed;

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
    final devSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
          child: Consumer<PlayerProvider>(builder: (context, provider, _) {
        // return  Image.asset(provider.imageURL!) ;
        return GestureDetector(
          onTap: (){
            if (_status == AnimationStatus.dismissed) {
              _controller.forward();
            }
            else {
                              _controller.reverse();
            }
          },
          child: Transform(
            alignment: FractionalOffset.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0015)
              ..rotateY(pi * _animation.value),
            child: Card(
              child: _animation.value <= 0.5
                  ? Container(
                height: devSize.height / 3,
                      child:  Image.asset(
                        'assets/cards/backSide.png',
                        fit: BoxFit.fill,
                      ),
                    )
                  : Container(
                    height: devSize.height / 3 ,
                      color: Colors.grey,
                      child: Image.asset(provider.imageURL!,fit: BoxFit.fill,)),
            ),
          ),
        );
      })),
    );
  }
}
