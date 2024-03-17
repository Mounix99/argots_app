import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

PagingController<int, Type> usePaginationScrollController<Type>(
    {required Future<List<Type>> Function(int page, int size) loadAction}) {
  return use(_PaginationScrollControllerHook(loadAction: loadAction));
}

class _PaginationScrollControllerHook<Type> extends Hook<PagingController<int, Type>> {
  const _PaginationScrollControllerHook({required this.loadAction, this.size = 20});

  final Future<List<Type>> Function(int nextPage, int size) loadAction;
  final int size;

  @override
  _PaginationScrollControllerHookState<Type> createState() => _PaginationScrollControllerHookState<Type>();
}

class _PaginationScrollControllerHookState<Type>
    extends HookState<PagingController<int, Type>, _PaginationScrollControllerHook<Type>> {
  late final PagingController<int, Type> controller = PagingController<int, Type>(firstPageKey: 1);

  @override
  void initHook() => controller.addPageRequestListener((pageKey) => _fetchPage(pageKey));

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await hook.loadAction(pageKey, hook.size);
      final isLastPage = newItems.length < hook.size;
      if (isLastPage) {
        controller.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        controller.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      controller.error = error;
    }
  }

  @override
  PagingController<int, Type> build(BuildContext context) => controller;

  @override
  void dispose() => controller.dispose();

  @override
  String? get debugLabel => 'usePaginationScrollController';
}
