import 'package:education_app/src/common_widgets/error_message_widget.dart';
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
      error: (err, _) => ErrorMessageWidget(
        errorMessage: err as String,
        retry: () {},
      ),
      loading: () => const SizedBox(
        height: 100,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
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
      error: (err, _) => SliverToBoxAdapter(
        child: Text(err as String),
      ),
      loading: () => const SliverToBoxAdapter(
        child: Center(
          child: SizedBox(height: 100, child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
