import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;

class FileManager {
static Future<void> saveJson(Map<String, dynamic> json, String fileName) async {
  final directoryPath = await FilePicker.platform.getDirectoryPath();
  if (directoryPath != null) {
    File(path.join(directoryPath, '$fileName.json'))
        .writeAsBytes(utf8.encode(jsonEncode(json)));
  }
}
}
