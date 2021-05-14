import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path/path.dart';

class PlayerMusic {
  final String musicTitle;
  final String pathMusic;
  PlayerMusic(this.musicTitle, this.pathMusic);
}

class Player extends StatefulWidget {
  @override
  _playMusic createState() => _playMusic();
}

class _playMusic extends State<Player> {
  //  late AnimationController controller;

  var styleTextoPrincipal =
      TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold);
  var styleTextoPrincipalMusic = TextStyle(
      backgroundColor: Colors.white,
      fontSize: 30,
      color: Colors.black,
      fontWeight: FontWeight.bold);
  AudioPlayer player = AudioPlayer();
  Duration position = new Duration(seconds: 0);
  Duration duration = new Duration(seconds: 0);
  int result = 0;
  double count = 0.0;
  double _currentSliderValue = 0;

  @override
  void dispose() {
    player.stop();
  }

  Widget build(BuildContext context) {
    final PlayerMusic args = ModalRoute.of(context).settings.arguments;

    if (result == 0) {
      play(args.pathMusic);
      player.onDurationChanged.listen((Duration d) {
        print('Max duration: $d');
        setState(() => duration = d);
      });
      player.onAudioPositionChanged.listen((Duration p) {
        print('Current position: $p');
        setState(() => position = p);
        setState(() => count++);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(args.musicTitle),
        backgroundColor: Colors.black,
      ),
      body: Column(children: [
        Card(
          color: Colors.white,
          child: Text(
            'Duração: ${duration}' + '\n' + 'Tempo  : ${position}',
            style: styleTextoPrincipalMusic,
          ),
        ),
        Card(
          child: Slider(
            value: _currentSliderValue,
            min: 0.0,
            max: duration.inMinutes.toDouble(),
            label: _currentSliderValue.round().toString(),
            divisions: 6,
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;

                player.seek(Duration(
                    minutes: duration.inMinutes - _currentSliderValue.toInt()));
              });
            },
          ),
        ),
        Card(
          shadowColor: Colors.blueAccent,
          child: LinearProgressIndicator(
            backgroundColor: Colors.blue,
            minHeight: 30,
            value:  (count/duration.inMinutes)/360,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
            semanticsValue:
                ((position.inMilliseconds.toDouble() / 3600) / 60).toString(),
            semanticsLabel: 'Andammento: ' +
                ((position.inMilliseconds.toDouble() / 3600) / 60).toString(),
          ),
        ),
        Container(
          child: Center(
            child: Column(
              children: [
                Column(
                  children: [
                    Center(
                      child: ToggleButtons(
                        renderBorder: true,
                        borderWidth: 5,
                        fillColor: Colors.blue,
                        borderColor: Colors.blue,
                        isSelected: [false, false, false],
                        selectedColor: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                        children: [
                          IconButton(
                            tooltip: 'Sair',
                            iconSize: 40,
                            icon: const Icon(Icons.exit_to_app_rounded),
                            color: Colors.red,
                            onPressed: () {
                              setState(
                                () {
                                  try {
                                    stop();
                                    Navigator.pop(context);
                                  } catch (e) {
                                    Navigator.pop(context);

                                    print("Tocador anulado:  ${e}");
                                  }
                                },
                              );
                            },
                          ),
                          IconButton(
                            tooltip: 'Pausa na música.',
                            iconSize: 40,
                            color: Colors.lightBlueAccent,
                            icon: const Icon(Icons.pause),
                            onPressed: () {
                              setState(
                                () {
                                  try {
                                    pause();
                                  } catch (e) {
                                    Navigator.pushNamed(context, '/lista');

                                    print("Tocador anulado:  ${e}");
                                  }
                                },
                              );
                            },
                          ),
                          IconButton(
                            tooltip: 'Continuar tocando.',
                            iconSize: 40,
                            color: Colors.greenAccent,
                            icon: const Icon(Icons.play_arrow),
                            onPressed: () {
                              setState(
                                () {
                                  try {
                                    resume();
                                  } catch (e) {
                                    Navigator.pushNamed(context, '/lista');

                                    print("Tocador anulado:  ${e}");
                                  }
                                },
                              );
                            },
                          ),
                         
                        ],
                       
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  play(url) async {
    result = await player.play(url, isLocal: true);
    if (result == 1) {
      // success
    }
  }

  pause() async {
    result = await player.pause();
    if (result == 1) {
      // success
    }
  }

  stop() async {
    result = await player.stop();
    if (result == 1) {
      // success
    }
  }

  resume() async {
    result = await player.resume();
    if (result == 1) {
      // success
    }
  }
}
