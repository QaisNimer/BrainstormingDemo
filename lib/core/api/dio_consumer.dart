import 'package:dio/dio.dart';
import 'api_consumer.dart';
import 'end_points.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;

  DioConsumer() : dio = Dio(
    BaseOptions(
      baseUrl: EndPoints.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  @override
  Future get(String path, {Map<String, dynamic>? queryParameters}) async {
    final response = await dio.get(path, queryParameters: queryParameters);
    return response.data;
  }

  @override
  Future post(String path, {Map<String, dynamic>? data}) async {
    final response = await dio.post(path, data: data);
    return response.data;
  }

  @override
  Future put(String path, {Map<String, dynamic>? data}) async {
    final response = await dio.put(path, data: data);
    return response.data;
  }
}
