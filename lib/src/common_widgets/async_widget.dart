import 'package:education_app/src/common_widgets/error_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../core/constants/assets.dart';

class AsyncWidget<T> extends StatelessWidget {
  const AsyncWidget({
    super.key,
    required this.value,
    required this.data,
    required this.retry,
  });

  final AsyncValue<T> value;
  final Widget Function(T) data;
  final VoidCallback retry;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (err, _) => ErrorMessageWidget(
        errorMessage: err is String ? err : '',
        retry: retry,
      ),
      loading: () => Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Lottie.asset(Assets.loading, width: 132, height: 132),
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
      loading: () => SliverToBoxAdapter(
        child: Center(
          child: Lottie.asset(Assets.loading, width: 132, height: 132),
        ),
      ),
    );
  }
}
