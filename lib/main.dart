// Copyright (c) 2022 jeffrey -at- ieee.org. All rights reserved.
// Use of this source code (/program) is governed by a GPLV3 license,
// that can be found in the LICENSE file. Do not remove this header.
import 'package:flutter/material.dart';
import 'reorderswipe.dart';
import 'elevatedbutton.dart';
import 'checkbox.dart';
import 'dropdown.dart';
import 'model.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

void main() {
  runApp(const MyApp());
  doWhenWindowReady(() {
    final win = appWindow;
    //const initialSize = Size(600, 450);
    //win.minSize = initialSize;
    //win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "XERtools Manager";
    win.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XERtools',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
      ),
       home: const MyHomePage(title: 'XERtools | Primavera P6 Schedule Analytics')
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


String activeFolder = ".";

List<XER> popXERs(String dir) {
    List<XER> xerStructs = [];
    List<FileSystemEntity> xerFiles = getXERs(dir);
    
    for(FileSystemEntity s in xerFiles) {
      xerStructs.add(XER(name: s.uri.pathSegments.last,modified: s.statSync().modified.toString(), fullpath: s.path));
    }
    return xerStructs;
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> currXERPaths = [];
  bool xerdumpWorking = false;
  bool xertaskWorking = false;
  bool xerpredWorking = false;
  bool xerdiffWorking = false;

  LabeledCheckbox cXERdumpSQL = LabeledCheckbox(label: "SQLite Database");
  LabeledCheckbox cXERdumpAppend = LabeledCheckbox(label: "Appended Tables");
  LabeledCheckbox cXERdumpMaster = LabeledCheckbox(label: "Master Table");
  LabeledCheckbox cXERdumpFolders = LabeledCheckbox(label: "Individual Folders");  
  LabeledCheckbox cXERtaskAnal = LabeledCheckbox(label: "Analytics Mode");
  LabeledCheckbox cXERpredDrive = LabeledCheckbox(label: "Output Drivers");
  LabeledCheckbox cXERpredPRed = LabeledCheckbox(label: "Output Predecessors");
  
  //////////////////
  /// CALLBACKS ////
  //////////////////
  _cbFolderSelect() async
  {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    activeFolder = selectedDirectory ?? ".";
    setState(() {});
  }

  _cbXERdump() async
  {
    Directory current = Directory.current;
    String retString = "";

    xerdumpWorking = true;
    setState(() {});

    List<String> params = currXERPaths;
    if (cXERdumpSQL.value) {
      params.add("-s");
    } 
    if (cXERdumpAppend.value) {
      params.add("-a");
    } 
    if (cXERdumpMaster.value) {
      params.add("-c");
    } 
    if (cXERdumpFolders.value) {
      params.add("-i");
    } 

    print(params);

    try {
        if (Platform.isWindows) {
          retString = await execProcess("${current.path}/xerdump.exe",params);
        }
        else {
          retString = await execProcess("${current.path}/xerdump",params);
        }
      }
      on Exception {
              showDialog<String>(context: context, builder: (BuildContext context) => const AlertDialog(
            title: Text("Error"),
            content: Text("Could not find tool 'xerdump'.\nEnsure it is in the same folder."),
          ));
           xerdumpWorking = false;
           setState(() {});
          return;
    }

    xerdumpWorking = false;

    print(retString);

    showDialog<String>(context: context, builder: (BuildContext context) => const AlertDialog(
      title: Text("XER Dump has completed!"),
      content: Text("Output is in same path as this application."),
    ));
   
    setState(() {});
  }

  _cbXERtask() async
  {
    Directory current = Directory.current;
    String retString = "";

    xertaskWorking = true;
    setState(() {});

    List<String> params = currXERPaths;
    if (cXERtaskAnal.value) {
      params.add("-a");
    } 
    
    try {
        if (Platform.isWindows) {
          retString = await execProcess("${current.path}/xertask.exe",params);
        }
        else {
          retString = await execProcess("${current.path}/xertask",params);
        }
      }
      on Exception {
              showDialog<String>(context: context, builder: (BuildContext context) => const AlertDialog(
            title: Text("Error"),
            content: Text("Could not find tool 'xertask'.\nEnsure it is in the same folder."),
          ));
          xertaskWorking = false;
          setState(() {});
          return;
    }

    xertaskWorking = false;

    print(retString);

    showDialog<String>(context: context, builder: (BuildContext context) => const AlertDialog(
      title: Text("XER Task has completed!"),
      content: Text("Output is in same path as this application."),
    ));
   
    setState(() {});
  }

  _cbXERdiff() async
  {
    Directory current = Directory.current;
    String retString = "";

    xerdiffWorking = true;
    setState(() {});

    List<String> params = currXERPaths;
    
   try {
        if (Platform.isWindows) {
          retString = await execProcess("${current.path}/xerdiff.exe",params);
        }
        else {
          retString = await execProcess("${current.path}/xerdiff",params);
        }
      }
      on Exception {
              showDialog<String>(context: context, builder: (BuildContext context) => const AlertDialog(
            title: Text("Error"),
            content: Text("Could not find tool 'xerdiff'.\nEnsure it is in the same folder."),
          ));
          xerdiffWorking = false;
          setState(() {});
          return;
    }

    xerdiffWorking = false;

    print(retString);

    showDialog<String>(context: context, builder: (BuildContext context) => const AlertDialog(
      title: Text("XER Diff has completed!"),
      content: Text("Output is in same path as this application."),
    ));
   
    setState(() {});
  }

  _cbXERpred() async
  {
    Directory current = Directory.current;
    String retString = "";

    xerpredWorking = true;
    setState(() {});

    List<String> params = currXERPaths;
    if (cXERpredDrive.value) {
      params.add("-d");
    } 
    if (cXERpredPRed.value) {
      params.add("-p");
    } 

    try {
        if (Platform.isWindows) {
          retString = await execProcess("${current.path}/xerpred.exe",params);
        }
        else {
          retString = await execProcess("${current.path}/xerpred",params);
        }
      }
      on Exception {
              showDialog<String>(context: context, builder: (BuildContext context) => const AlertDialog(
            title: Text("Error"),
            content: Text("Could not find tool 'xerpred'.\nEnsure it is in the same folder."),
          ));
          xerpredWorking = false;
          setState(() {});
          return;
    }

    xerpredWorking = false;

    print(retString);

    showDialog<String>(context: context, builder: (BuildContext context) => const AlertDialog(
      title: Text("XER Pred has completed!"),
      content: Text("Output is in same path as this application."),
    ));
   
    setState(() {});
  }

  _cbReload() async
  {
     setState(() {});
  }

  _cbCheckUpdates() async
  {
   
    void _updateSnack(String util) async {

       Directory current = Directory.current;
       String retString = "";

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Updating $util!"),duration: Duration(milliseconds: 500)));

       try {
        if (Platform.isWindows) {
          retString =await execProcess("${current.path}/$util.exe",["-u","-z"]);
        }
        else {
          retString =await execProcess("${current.path}/$util",["-u","-z"]);
        }

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Done updating $util!"),duration: Duration(milliseconds: 500)));
        print(retString);
      }
      on Exception {
              showDialog<String>(context: context, builder: (BuildContext context) => AlertDialog(
            title: const Text("Error"),
            content: Text("Could not find tool '$util'.\nEnsure it is in the same folder."),
          ));
          xerpredWorking = false;
          setState(() {});
          return;
    }
      
 
    }

    _updateSnack("xerdump");
    _updateSnack("xertask");
    _updateSnack("xerpred");
    _updateSnack("xerdiff");

    
     //setState(() {});
  }


  @override
  Widget build(BuildContext context) {

    ///////////////
    /// WIDGETS ///
    ///////////////
    AElevatedButton buttonFolder = AElevatedButton(buttonText:"Select Folder",onTap:_cbFolderSelect,buttonTooltip: "Select a folder with XER files");
    AElevatedButton buttonReload =  AElevatedButton(buttonText:"Reload XERs",onTap:_cbReload,buttonTooltip: "Reload XER files from directory");
    AElevatedButton buttonXERdump =  AElevatedButton(buttonText:"XER Dump",onTap:_cbXERdump, buttonTooltip: "Extract all embedded tables in XERs to SQL, individual folders, or master tables");
    AElevatedButton buttonXERtask =  AElevatedButton(buttonText:"XER Task",onTap:_cbXERtask, buttonTooltip: "Transform XER TASK data, and ajoin it to the PROJECT and CALENDAR tables. \nOr perform a detailed analysis on the XER TASK table.");
    AElevatedButton buttonXERpred =  AElevatedButton(buttonText:"XER Pred",onTap:_cbXERpred, buttonTooltip: "Output a list of every task code with its predecessors, descending recursively to the specified depth",);
    AElevatedButton buttonXERdiff =  AElevatedButton(buttonText:"XER Diff",onTap:_cbXERdiff, buttonTooltip: "Identify what task codes have been added or deleted between 2 or more XER files");
    
    ADropDown ddPredDepth = ADropDown();
    XERList ttl = XERList();

    //////////////
    /// STATES ///
    //////////////
    ttl.items = popXERs(activeFolder);
    ddPredDepth.dropDownText = "Generation Depth";
    currXERPaths = ttl.currentPaths();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          PopupMenuButton(itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                    child: Text("Check for Updates"),
                    onTap: () {
                      _cbCheckUpdates();
                    }),
            ];
          })
        ],
      ),
      
        body: Column(
          children:  <Widget>[
            Expanded(child:ttl),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[buttonFolder,buttonReload]),
            const Divider(color: Colors.redAccent,height: 10,thickness: 2,indent: 10,endIndent: 10,),
            Row(children: <Widget>[Container(width: 200, child:buttonXERdump),cXERdumpSQL,cXERdumpFolders,cXERdumpAppend,cXERdumpMaster,const SizedBox(width: 20), xerdumpWorking ?const  CircularProgressIndicator() : const SizedBox(height: 20)]),
            const Divider(color: Colors.redAccent,height: 20,thickness: 2,indent: 10,endIndent: 10),
            Row(children: <Widget>[Container(width: 200, child:buttonXERtask),cXERtaskAnal,const SizedBox(width: 20), xertaskWorking ? const CircularProgressIndicator() : const SizedBox(height: 20)]),
            const Divider(color: Colors.redAccent,height: 20,thickness: 2,indent: 10,endIndent: 10),
            Row(children: <Widget>[Container(width: 200, child:buttonXERpred),Column(crossAxisAlignment: CrossAxisAlignment.start,  children: <Widget>[Row(children: <Widget>[cXERpredDrive]),Row(children: <Widget>[cXERpredPRed,ddPredDepth])]),Column(children: [const SizedBox(width: 20), xerpredWorking ? const CircularProgressIndicator() :const  SizedBox(height: 20)],)]),
            const Divider(color: Colors.redAccent,height: 20,thickness: 2,indent: 10,endIndent: 10),
            Row(children: <Widget>[Container(width: 200, child:buttonXERdiff),const SizedBox(width: 20), xerdiffWorking ? const CircularProgressIndicator() :const  SizedBox(height: 20)]),
             const Divider(color: Colors.redAccent,height: 20,thickness: 2,indent: 10,endIndent: 10),
            const SizedBox(height: 20),
             Container(
                child: new Image(image: AssetImage('assets/logo_white.png')),
                alignment: Alignment.center,
              ),
            const SizedBox(height: 20),
          ]
        ),
    );
  }
}
