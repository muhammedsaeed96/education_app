import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncWidget<T> extends StatelessWidget {
  const AsyncWidget({super.key, required this.value, required this.data});

  final AsyncValue<T> value;
  final Widget Function(T) data;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (err, _) =>  Text(err as String),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class AsyncSliverWidget<T> extends StatelessWidget {
  const AsyncSliverWidget({super.key, required this.value, required this.data});

  final AsyncValue<T> value;
  final Widget Function(T) data;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (err, _) =>  SliverToBoxAdapter(
        child: Text(err as String),
      ),
      loading: () => const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
