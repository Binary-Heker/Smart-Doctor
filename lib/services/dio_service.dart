import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioService {
  Dio dio = Dio(
    BaseOptions(
      validateStatus: (status) => status! < 500,
    ),
  );
  final String apiKey = dotenv.env['API_KEY']!;

  final String baseUrl;

  DioService(
    this.baseUrl,
  ) {
    dio.options.baseUrl = "$baseUrl?key=$apiKey";
  }

  Future<Response> get(String path) async {
    return await dio.get(
      path,
    );
  }

  Future<Response> post(
    String path,
    Map data,
  ) async {
    return await dio.post(
      path,
      data: data,
    );
  }
}
