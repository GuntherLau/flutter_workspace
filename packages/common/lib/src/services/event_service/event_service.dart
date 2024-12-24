import 'event_listener.dart';

class EventService {

  static final EventService _instance = EventService._internal();
  EventService._internal();
  static EventService get instance => _instance;

  final _listeners = <String, List<EventListener>>{};

  void addListener(String eventId, EventListener listener) {
    if (!_listeners.containsKey(eventId)) {
      _listeners[eventId] = [];
    }
    final eventListeners = _listeners[eventId]!;
    if (!eventListeners.contains(listener)) {
      eventListeners.add(listener);
    }
  }

  void removeListener(String eventId, EventListener listener) {
    final eventListeners = _listeners[eventId];
    eventListeners?.remove(listener);
    // 如果该 eventId 的监听器列表为空，则移除该 key
    if (eventListeners != null && eventListeners.isEmpty) {
      _listeners.remove(eventId);
    }
  }

  void dispatchEvent(String eventId, dynamic data) {
    final eventListeners = _listeners[eventId];
    if (eventListeners != null) {
      for (var listener in eventListeners) {
        listener.onEvent(eventId, data);
      }
    }
  }

}