import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Musica(),
    ),
  );
}

//Vc tem estado você consegue fazer varios efeitos dentro da tela
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var count = 0;
  AnimationController _animationController;
  Animation _animation;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        upperBound: 5.0,
        duration: Duration(
          milliseconds: 4000,
        ));
    _animationController.repeat(
      period: Duration(milliseconds: 4000),
    );
    //_animationController.forward();

    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  void increment() {
    count++;
    setState(() {});
  }

  @override
  //consegue renderizar o que eu quiser
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF330004),
        child: Icon(Icons.add),
        onPressed: () {
          increment();
          print(count);
        },
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFF330004),
        title: Text("<nlw: 01 – A Base do Flutter/> "),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        //color: Colors.black,
        //padding: EdgeInsets.all(8),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      stops: [
                        _animation.value - 0.5,
                        _animation.value,
                        _animation.value + 0.5,
                        _animation.value,
                        _animation.value - 0.5,
                      ],
                      //center: Alignment.topLeft,
                      //radius: 1.0,
                      colors: [
                        Color(int.parse("0xFFFFFFFF")),
                        Color(int.parse("0xFF8A0622")),
                        Color(int.parse("0xFF330004")),
                        Color(int.parse("0xFFD6CFD5")),
                        Color(int.parse("0xFF330004")),
                      ],
                      tileMode: TileMode.mirror,
                    ).createShader(bounds);
                  },
                  child: Text("Quantas vezes a música tocou?\n$count",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontFamily: "Creepster")),
                ),
                Container(
                  height: 350,
                  width: 250,
                  child: Image(image: AssetImage("assets/1.gif")),
                ),
              ]
              //
              ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Color(0xFF330004),
          child: Text(
            '©2021 Dev Pabricio Freitas',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          padding: EdgeInsets.all(16.0),
        ),
      ),
      // Color.fromARGB() our Color.fromRFBO() our Color(0xFFFF9011)
    );
  }
}

class Musica extends StatefulWidget {
  @override
  _MusicaState createState() => _MusicaState();
}

class _MusicaState extends State<Musica> {
  @override
  Widget build(BuildContext context) {
    final player =
        AudioCache(fixedPlayer: AudioPlayer(), respectSilence: false);
    player.loop('2.mp3', volume: 1.0);

    return HomePage();
  }
}
