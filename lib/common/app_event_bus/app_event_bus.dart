import 'dart:async';

enum AppEvent { plantsUpdated, fieldsUpdated, profileUpdated }

class AppEventBus {
  final _controller = StreamController<AppEvent>.broadcast();

  Stream<AppEvent> get stream => _controller.stream;

  void fire(AppEvent event) => _controller.add(event);

  void dispose() => _controller.close();
}
