import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'dart:io';
import '../playermusic.dart';

//apply this class on home: attribute at MaterialApp()
class MyFileListMusic extends StatefulWidget {
  @override
  _MyFileList createState() => _MyFileList();
}

class _MyFileList extends State<MyFileListMusic> {
  var files;

  void getFiles() async {
    //asyn function to get list of files
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    var root = storageInfo[1]
        .rootDir; //storageInfo[1] for SD card, geting the root directory
    var fm = FileManager(root: Directory(root)); //
    files = await fm.filesTree(
        //set fm.dirsTree() for directory/folder tree list
        excludedPaths: ["/storage/emulated/0/Android/Music"],
        extensions: ["mp3"] //optional, to filter files, remove to list all,
        //remove this if your are grabbing folder list
        );
    setState(() {}); //update the UI
  }

  @override
  void initState() {
    getFiles(); //call getFiles() function on initial state.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("LISTA DE MÚSICAS"), backgroundColor: Colors.black),
        body: files == null
            ? Text("Buscando arquivos")
            : ListView.builder(
                //if file/folder list is grabbed, then show here
                itemCount: files?.length ?? 0,

                itemBuilder: (context, index) {
                  return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      color: Colors.blue,

                    child: ListTile(
                    
                    
                    selectedTileColor: Colors.blue,
                    focusColor: Colors.deepOrange,

                    title: Text(
                      files[index].path.split('/').last,
                      textScaleFactor: 1, style: TextStyle(color: Colors.white) ,  ),
                   // tileColor: Colors.blueGrey[100],
                    leading: Icon(
                      Icons.music_note_sharp,
                      size: 35,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/music',
                          arguments: PlayerMusic(
                              files[index].path.split('/').last,
                              files[index].path.toString()));
                    },

                    // trailing: Icon(
                    //   Icons.delete,
                    //   color: Colors.redAccent,
                    // ),
                  ));
                },
              ));
  }
}
