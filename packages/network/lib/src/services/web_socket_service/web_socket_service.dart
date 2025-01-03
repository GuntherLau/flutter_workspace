

class WebSocketService {

  static final WebSocketService _instance = WebSocketService._internal();
  WebSocketService._internal();
  static WebSocketService get instance => _instance;

  Future<void> init() async {

  }

}