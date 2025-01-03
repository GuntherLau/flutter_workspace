import 'dart:convert';

import 'package:dio/dio.dart';

class BusinessInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // if(AccountService.instance.isLogin()) {
    //   options.headers.addAll(generatorHeaderWithToken(AccountService.instance.currentUser!.token!));
    // }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    Map<String, dynamic> map = jsonDecode(response.toString());
    if(map.isNotEmpty) {
      //未登录需要拦截一下
      // if(map["code"] == HttpResponseStatus.NOT_LOGIN){
      //   //这里可以发消息，发完消息之后走success回调
      //   AccountService.sharedInstance.logoutUser();
      //   eventBus.fire(UserTokenInvalidEvent());
      //   response.data = {'code': 200, 'msg': '令牌无效','data': null};
      //   handler.next(response);
      // }else{
      //   handler.next(response);
      // }
      handler.next(response);
    }
  }

}