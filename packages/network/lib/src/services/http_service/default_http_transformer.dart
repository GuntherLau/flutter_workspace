import 'package:dio/dio.dart';

import '../../http/http_engine.dart';



class HttpResponseStatus {
  static int NOT_LOGIN = 401;
  static int SUCESS = 200;
}

class DefaultHttpTransformer extends HttpTransformer {
  @override
  CustomHttpResponse parse(Response response) {
    if (response.statusCode == HttpResponseStatus.SUCESS) {
      return CustomHttpResponse.success(response.data["data"], response.data['code'], response.data['msg']);
    } else if(response.statusCode == HttpResponseStatus.NOT_LOGIN) {
      return CustomHttpResponse.success(response.data["data"], response.data['code'], response.data['msg']);
    } else{
      return CustomHttpResponse.failure(errorMsg: response.data["msg"], errorCode: response.data["code"]);
    }
  }
}