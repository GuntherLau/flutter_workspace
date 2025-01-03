
import '../../http/http_config.dart';
import '../../http/http_engine.dart';
import 'default_http_transformer.dart';
import 'time_interceptor.dart';
import 'business_interceptor.dart';

typedef Success<T> = Function(T data);
typedef Fail = Function(int code, String msg);

class HttpService {

  static final HttpService _instance = HttpService._internal();
  HttpService._internal();
  static HttpService get instance => _instance;

  late HttpEngine _engine;
  String _errorMessage = '服务器异常';

  Future<void> init({
    required String baseUrl,
    String? proxy,
    String? errorMessage
  }) async {
    final HttpConfig httpConfig = HttpConfig(
      baseUrl,
      interceptors: [
        TimeInterceptor(),
        BusinessInterceptor()
      ],
      format: DefaultHttpTransformer(),
      connectTimeout: 15 * 1000,
    );
    if (proxy != null && proxy != "") {
      httpConfig.proxy = proxy;
    }
    if(errorMessage != null) {
      _errorMessage = errorMessage;
    }
    _engine = HttpEngine.instance(httpConfig);
  }

  // HttpService() {
  //   AppConfig appConfig = Get.find<AppConfig>();
  //   String? proxy = SPUtil.instance.getString(AppCacheKeys.kProxy);
  //   if (proxy != null && proxy != "") {
  //     httpConfig.proxy = proxy;
  //   }
  // }

  Future<CustomHttpResponse> loginByPwd({
    required String email,
    required String pwd,
    required Success<String> success,
    required Fail fail,
  }) async {
    print("HttpService.loginByPwd email:$email pwd:$pwd");
    late CustomHttpResponse response;
    try {
      String path = "/auth/login";

      var body = {
        "username": email,
        "password": pwd
      };
      response = await _engine.execute(Method.POST, path, data: body);
      if (response.ok) {
        String accessToken = response.data['access_token'];
        success(accessToken);
      } else {
        fail(response.error?.code ?? -1, response.error?.message ?? _errorMessage);
      }
    } catch(e) {
      fail(-1, e.toString());
      return response;
    }
    return response;
  }

}