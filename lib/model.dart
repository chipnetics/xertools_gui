import 'dart:io';

void main() async {

  print("running...");
  
  
  
}

List<FileSystemEntity> getXERs(String dir) {
  
  List<FileSystemEntity> xerFiles = [];

  List<FileSystemEntity> dirFiles = listFiles(dir);
  final iter = dirFiles.whereType<File>();

  for(File s in iter) {
    if(s.uri.toString().endsWith(".xer")) {
      xerFiles.add(s);
    }
  }

  return xerFiles;

}

List<FileSystemEntity> listFiles(String directory)  {
  final dir = Directory(directory);
  final List<FileSystemEntity> entities =  dir.listSync().toList();

  return entities;
}

Future<String> execProcess(String exe, List<String> params) async {

  ProcessResult pr = await Process.run(exe, params);

  return pr.stdout;

  //Process.run(exe, params).then((ProcessResult results) { print(results.stdout); return results.stdout; });
}
