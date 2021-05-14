import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Principal extends StatelessWidget {
  // Fonte de texto
  var a = 0;
  var styleTextoPrincipal =
      TextStyle(fontSize: 30, color: Colors.amber, fontWeight: FontWeight.bold);
  var styleTexto = TextStyle(
      fontSize: 30,
      color: Colors.lightBlue.shade900,
      fontWeight: FontWeight.bold);
  final List<String> entries = <String>['1', '2', '3'];
  final List<int> colorCodes = <int>[800, 800, 800];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.black,
            primaryTextTheme: TextTheme(
                // ignore: deprecated_member_use
                title: TextStyle(fontSize: 30, color: Colors.blueAccent))),
        home: Scaffold(
          appBar: AppBar(centerTitle: true, title: Text("PLAYER MUSIC")),
          drawer: Drawer(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  color: Colors.blue[colorCodes[index]],
                  child: Center(child: Text('OPCAO ${entries[index]}')),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          ),
          body: Column(children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                      child: Image(
                    image: AssetImage('assets/images/img1.jpg'),
                  )),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                      height: 50,
                      width: 100,
                      color: Colors.orangeAccent,
                      // ignore: deprecated_member_use
                      child: FlatButton(
                          splashColor: Colors.amber,
                          color: Colors.amber[900],
                          onPressed: () {
                            Navigator.pushNamed(context, '/lista');
                          },
                          child: Icon(Icons.list_alt_sharp,
                              size: 40, color: Colors.white))),
                ),
                // Expanded(
                //   child: Container(
                //       height: 50,
                //       width: 100,
                //       color: Colors.greenAccent,
                //       // ignore: deprecated_member_use
                //       child: FlatButton(
                //           color: Colors.indigoAccent,
                //           onPressed: () {
                //             print('Seila ');
                //           },
                //           child: Icon(
                //             Icons.timelapse_rounded,
                //             size: 40,
                //             color: Colors.white,
                //           ))),
                // )
              ],
            ),
            Column(
              children: [
                Center(
                  child: Center(
                    child: FlatButton(
                        onPressed: () {
                          exit(0);
                        },
                        child: Icon(
                          Icons.exit_to_app_rounded,
                          size: 80,
                          color: Colors.black45,
                        )),
                  ),
                )
              ],
            )
          ]),
        ));
  }
}
