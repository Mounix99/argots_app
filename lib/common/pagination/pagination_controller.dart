import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

PagingController<int, T> usePaginationScrollController<T>(
    {required Future<List<T>> Function(int page, int size) loadAction,
    int size = 20}) {
  return use(_PaginationScrollControllerHook(loadAction: loadAction, size: size));
}

class _PaginationScrollControllerHook<T> extends Hook<PagingController<int, T>> {
  const _PaginationScrollControllerHook({required this.loadAction, this.size = 20});

  final Future<List<T>> Function(int nextPage, int size) loadAction;
  final int size;

  @override
  _PaginationScrollControllerHookState<T> createState() => _PaginationScrollControllerHookState<T>();
}

class _PaginationScrollControllerHookState<T>
    extends HookState<PagingController<int, T>, _PaginationScrollControllerHook<T>> {
  late final PagingController<int, T> controller = PagingController<int, T>(
    getNextPageKey: (state) => state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage: (pageKey) => hook.loadAction(pageKey, hook.size),
  );

  @override
  PagingController<int, T> build(BuildContext context) => controller;

  @override
  void dispose() => controller.dispose();

  @override
  String? get debugLabel => 'usePaginationScrollController';
}
