import 'package:dio/dio.dart';
class TimeInterceptor implements Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 在请求发送前记录时间
    options.extra['startTime'] = DateTime.now().millisecondsSinceEpoch;
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 在响应接收后计算时间差
    int startTime = response.requestOptions.extra['startTime'];
    int endTime = DateTime.now().millisecondsSinceEpoch;
    int duration = endTime - startTime;
    print('请求 ${response.requestOptions.baseUrl}${response.requestOptions.path} ${response.requestOptions.method} 耗时: $duration ms');
    handler.next(response);
  }

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) {
    // 如果发生错误，也尝试计算时间差（如果有开始时间记录）
    if (error.requestOptions.extra.containsKey('startTime')) {
      int startTime = error.requestOptions.extra['startTime'];
      int endTime = DateTime.now().millisecondsSinceEpoch;
      int duration = endTime - startTime;
      print('请求 ${error.requestOptions.path} 出错，已耗时: $duration ms');
    }
    handler.next(error);
  }

}