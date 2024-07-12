import 'dart:developer';

import 'package:dio/dio.dart';

Future<bool> downloadAudio({
  required String url,
  required String savePath,
}) async {
  final dio = Dio();
  try {
    final response = await dio.download(url, savePath);
    log(response.statusCode.toString());
    return response.statusCode == 200;
  } catch (e) {
    throw Exception(e.toString());
  }
}
