import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'http_config.dart';
import 'http_exceptions.dart';

class CustomHttpResponse {
  late bool ok;
  dynamic data;
  final int? statusCode;
  String? msg;
  HttpException? error;

  CustomHttpResponse._internal(this.statusCode, {this.ok = false});

  CustomHttpResponse.success(this.data, this.statusCode, this.msg) {
    ok = true;
  }

  CustomHttpResponse.failure({String? errorMsg, int? errorCode,this.statusCode = -1}) {
    error = BadRequestException(message: errorMsg, code: errorCode);
    ok = false;
  }

  CustomHttpResponse.failureFormResponse({dynamic? data,this.statusCode = -1}) {
    error = BadResponseException(data);
    ok = false;
  }

  CustomHttpResponse.failureFromError(this.statusCode, [HttpException? errorE]) {
    error = errorE ?? UnknownException();
    ok = false;
  }
}

class HttpEngine {
  final HttpConfig _config;
  late Dio _dio;

  Dio get dio {
    return _dio;
  }

  HttpEngine._internal(this._config) {
    BaseOptions options = BaseOptions(
        baseUrl: _config.baseUrl,
        connectTimeout: Duration(milliseconds: _config.connectTimeout),
        receiveTimeout: Duration(milliseconds: _config.receiveTimeout),
        contentType: Headers.jsonContentType);

    // DioCacheManager
    final cacheOptions = CacheOptions(
      // A default store is required for interceptor.
      store: MemCacheStore(),
      // Optional. Returns a cached response on error but for statuses 401 & 403.
      hitCacheOnErrorExcept: [401, 403],
      // Optional. Overrides any HTTP directive to delete entry past this duration.
      maxStale: const Duration(days: 7),
    );

    List<Interceptor> interceptors = [
      DioCacheInterceptor(options: cacheOptions),
      PrettyDioLogger(
          maxWidth: 200,
          compact: false,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true),
    ];
    if (_config.interceptors != null && _config.interceptors!.isNotEmpty) {
      interceptors.addAll(_config.interceptors!);
    }
    // Cookie管理
    // if (_config?.cookiesPath?.isNotEmpty ?? false) {
    //   interceptors.add(CookieManager(
    //       PersistCookieJar(storage: FileStorage(_config!.cookiesPath))));
    // }

    _dio = Dio(options);
    _dio.interceptors.addAll(interceptors);
  }

  HttpConfig getConfig() {
    return _config;
  }

  static HttpEngine instance(
      HttpConfig config, {
        BaseOptions? options,
      }) {
    return HttpEngine._internal(config);
  }

  Future<CustomHttpResponse> execute(
      Method method,
      String path, {
        data,
        HttpTransformer? format,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    Options ops = options != null
        ? options.copyWith(method: _methodValues[method])
        : Options(
      method: _methodValues[method],
    );

    late Response response;
    try {
      response = await dio.request(path,
          data: data,
          queryParameters: params,
          options: ops);
      return handleResponse(response, format ?? _config.format);
    } on DioException catch (e) {
      int? statusCode = e.response?.statusCode ?? -1; // 获取 HTTP 状态码
      String? message = e.response?.statusMessage ?? e.message; // 获取错误信息
      return CustomHttpResponse.failure(
        errorMsg: message,
        errorCode: statusCode,
      );
    }
  }

  handleResponse(Response response,HttpTransformer? format) {
    print("handleResponse statusCode:${response.statusCode} data:${response.data}");
    if(response.data['code'] == 200) {
      if(format == null) {
        return CustomHttpResponse.success(response.data, response.data['code'], response.data['msg']);
      } else {
        return format.parse(response);
      }
    } else {
      return CustomHttpResponse.failure(errorMsg: response.data['msg'], errorCode: response.data['code']);
    }
  }

}

abstract class HttpTransformer {
  CustomHttpResponse parse(Response response);
}


///请求类型枚举
enum Method { GET, POST, DELETE, PUT, PATCH, HEAD }

///请求类型值
const _methodValues = {
  Method.GET: "get",
  Method.POST: "post",
  Method.DELETE: "delete",
  Method.PUT: "put",
  Method.PATCH: "patch",
  Method.HEAD: "head",
};
