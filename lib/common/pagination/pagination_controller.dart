import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PaginationScrollController {
  late ScrollController scrollController;
  bool isLoading = false;
  bool stopLoading = false;
  int currentPage = 1;
  double boundaryOffset = 0.5;
  late Function(int nextPage) loadAction;

  void init({Function? initAction, required Function(int nextPage) loadAction}) {
    if (initAction != null) {
      initAction();
    }
    this.loadAction = loadAction;
    scrollController = ScrollController()..addListener(scrollListener);
  }

  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
  }

  void scrollListener() {
    if (!stopLoading) {
      //load more data
      if (scrollController.offset >= scrollController.position.maxScrollExtent * boundaryOffset && !isLoading) {
        isLoading = true;
        loadAction(currentPage + 1).then((shouldStop) {
          isLoading = false;
          currentPage++;
          boundaryOffset = 1 - 1 / (currentPage * 2);
          if (shouldStop == true) {
            stopLoading = true;
          }
        });
      }
    }
  }
}

PaginationScrollController usePaginationScrollController(
    {Function? initAction, required Function(int page) loadAction}) {
  return use(_PaginationScrollControllerHook(initAction: initAction, loadAction: loadAction));
}

class _PaginationScrollControllerHook extends Hook<PaginationScrollController> {
  const _PaginationScrollControllerHook({this.initAction, required this.loadAction});

  final Function? initAction;
  final Function(int nextPage) loadAction;

  @override
  _PaginationScrollControllerHookState createState() => _PaginationScrollControllerHookState();
}

class _PaginationScrollControllerHookState
    extends HookState<PaginationScrollController, _PaginationScrollControllerHook> {
  late final PaginationScrollController controller = PaginationScrollController();

  @override
  void initHook() => controller.init(loadAction: hook.loadAction, initAction: hook.initAction);

  @override
  PaginationScrollController build(BuildContext context) => controller;

  @override
  void dispose() => controller.dispose();

  @override
  String? get debugLabel => 'usePaginationScrollController';
}
