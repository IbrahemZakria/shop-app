import 'package:dio/dio.dart';

// const String baseUrl='newsapi.org';
// const String ApiKey='5d907bddc59041cfa4ad0078a86896bc';
class diohelper {
  static Dio dio = Dio(
    BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl: "https://student.valuxapps.com/api/",
        headers: {'Content-Type': 'application/json'}),
  );

  static Future<Response?> getdata(
      {required String url,
      Map<String, dynamic>? query,
      String? token,
      String lang = 'ar'}) async {
    dio.options.headers = {'Authorization': token, 'lang': lang};
    return await dio.get(url, queryParameters: query,);
  }

  static Future<Response?> postdata(
      {required String url,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      String? token,
      String lang = 'ar'}) async {
    dio.options.headers = {'Authorization': token, 'lang': lang};
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }static Future<Response?> putdata(
      {required String url,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      String? token,
      String lang = 'ar'}) async {
    dio.options.headers = {'Authorization': token, 'lang': lang};
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
