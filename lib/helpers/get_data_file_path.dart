import "package:path_provider/path_provider.dart";

Future<String> getDataFilePath(String modelName) async {
  final directory = await getApplicationDocumentsDirectory();
  return '${directory.path}/${modelName}.json';
}
