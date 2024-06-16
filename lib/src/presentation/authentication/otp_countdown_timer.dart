import 'package:education_app/src/core/constants/app_colors.dart';
import 'package:education_app/src/core/constants/app_text_styles.dart';
import 'package:education_app/src/core/utils/async_init.dart';
import 'package:education_app/src/presentation/controllers/sample_state_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OtpCountDownTimer extends ConsumerStatefulWidget {
  OtpCountDownTimer({super.key});

  @override
  ConsumerState<OtpCountDownTimer> createState() => _OtpCountDownTimerState();
}

class _OtpCountDownTimerState extends ConsumerState<OtpCountDownTimer>
    with SingleTickerProviderStateMixin {
  late final AppLifecycleListener _listener;

  AnimationController? _animationController;
  Animation<int>? animation;

  void _startTimer() {
    final levelClock =
        ref.read(asyncInitProvider).otpHelper.getNextOtpAttemptInSeconds();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: levelClock),
    );
    _animationController!.forward();
    animation = StepTween(
      begin: levelClock, // THIS IS A USER ENTERED NUMBER
      end: 0,
    ).animate(_animationController!)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // to make request otp available when timer finished
          ref.read(requestOtpAvailableProvider.notifier).state = true;
        }
      });
  }

  void _resetTimer() {
    _animationController?.reset();
  }

  @override
  void initState() {
    super.initState();
    // Initialize the AppLifecycleListener class and pass callbacks
    _listener = AppLifecycleListener(
      onStateChange: _onStateChanged,
    );
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _startTimer();
        if (context.mounted) {
          setState(() {});
        }
      },
    );
  }

  // Listen to the app lifecycle state changes
  void _onStateChanged(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _onResumed();
    }
  }

  void _onResumed() async {
    _resetTimer();
    _startTimer();
    if (context.mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    // Do not forget to dispose the listener
    _listener.dispose();
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return animation != null
        ? Countdown(animation: animation!)
        : const SizedBox();
  }
}

class Countdown extends AnimatedWidget {
  const Countdown({
    super.key,
    required this.animation,
  }) : super(listenable: animation);
  final Animation<int> animation;

  @override
  build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final hours = strDigits(animation.value ~/ 3600);
    final minutes = strDigits((animation.value % 3600) ~/ 60);
    final remainingSeconds = strDigits(animation.value % 60);
    String timerText = '$hours:$minutes:$remainingSeconds';
    return Text(
      ' $timerText ',
      style: AppTextStyles.textMediumStyle16.copyWith(
        color: AppColors.primaryColor400,
      ),
      textAlign: TextAlign.end,
    );
  }
}
