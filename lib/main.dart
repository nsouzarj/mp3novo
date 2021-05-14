

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymusics/playermusic.dart';
import 'principal/principal.dart';
import 'hardwarePhone/lista.dart';
import 'playermusic.dart';


void main() {
  runApp(MaterialApp(
    title: 'Teste',
    initialRoute: '/home',
    routes: {
      '/home': (context) => Principal(),
      '/lista': (context)=>MyFileListMusic(),
      '/music':(context)=>Player()
    },
    
  ));
}
