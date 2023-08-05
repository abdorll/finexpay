import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/styles.dart';
import 'package:local_coin/view/screens/lock_screen/widget/src/configurations/key_pad_config.dart';
import 'package:local_coin/view/screens/lock_screen/widget/src/configurations/screen_lock_config.dart';
import 'package:local_coin/view/screens/lock_screen/widget/src/configurations/secrets_config.dart';
import 'package:local_coin/view/screens/lock_screen/widget/src/input_controller.dart';
import 'package:local_coin/view/screens/lock_screen/widget/src/layout/key_pad.dart';
import 'package:local_coin/view/screens/lock_screen/widget/src/layout/secrets.dart';

class ScreenLock extends StatefulWidget {
  /// Animated ScreenLock
  const ScreenLock({
    super.key,
    required String this.correctString,
    required VoidCallback this.onUnlocked,
    this.onOpened,
    this.onValidate,
    this.onCancelled,
    this.onError,
    this.onMaxRetries,
    this.maxRetries = 0,
    this.retryDelay = Duration.zero,
    Widget? title,
    this.config,
    SecretsConfig? secretsConfig,
    this.keyPadConfig,
    this.delayBuilder,
    this.customizedButtonChild,
    this.customizedButtonTap,
    this.footer,
    this.cancelButton,
    this.deleteButton,
    this.inputController,
    this.secretsBuilder,
    this.useBlur = true,
    this.useLandscape = true,
  })  : title = title ?? const Text('Please enter passcode.'),
        confirmTitle = null,
        digits = correctString.length,
        onConfirmed = null,
        secretsConfig = secretsConfig ?? const SecretsConfig(),
        assert(maxRetries > -1, 'max retries cannot be less than 0'),
        assert(correctString.length > 0, 'correct string cannot be empty');

  /// Animated ScreenLock
  const ScreenLock.create({
    super.key,
    required ValueChanged<String> this.onConfirmed,
    this.onOpened,
    this.onValidate,
    this.onCancelled,
    this.onError,
    this.onMaxRetries,
    this.maxRetries = 0,
    this.digits = 4,
    this.retryDelay = Duration.zero,
    Widget? title,
    Widget? confirmTitle,
    this.config,
    SecretsConfig? secretsConfig,
    this.keyPadConfig,
    this.delayBuilder,
    this.customizedButtonChild,
    this.customizedButtonTap,
    this.footer,
    this.cancelButton,
    this.deleteButton,
    this.inputController,
    this.secretsBuilder,
    this.useBlur = true,
    this.useLandscape = true,
  })  : correctString = null,
        title = title ?? const Text('Please enter new passcode.'),
        confirmTitle =
            confirmTitle ?? const Text('Please confirm new passcode.'),
        onUnlocked = null,
        secretsConfig = secretsConfig ?? const SecretsConfig(),
        assert(maxRetries > -1);

  final String? correctString;
  final VoidCallback? onUnlocked;
  final ValidationCallback? onValidate;
  final VoidCallback? onOpened;
  final VoidCallback? onCancelled;
  final ValueChanged<String>? onConfirmed;
  final ValueChanged<int>? onError;
  final ValueChanged<int>? onMaxRetries;
  final VoidCallback? customizedButtonTap;
  final int maxRetries;
  final int digits;
  final Duration retryDelay;
  final Widget title;
  final Widget? confirmTitle;
  final ScreenLockConfig? config;
  final SecretsConfig secretsConfig;
  final KeyPadConfig? keyPadConfig;
  final DelayBuilderCallback? delayBuilder;
  final Widget? customizedButtonChild;
  final Widget? footer;
  final Widget? cancelButton;
  final Widget? deleteButton;
  final InputController? inputController;
  final SecretsBuilderCallback? secretsBuilder;
  final bool useBlur;
  final bool useLandscape;

  @override
  State<ScreenLock> createState() => _ScreenLockState();
}

class _ScreenLockState extends State<ScreenLock> {
  late InputController inputController =
      widget.inputController ?? InputController();

  int retries = 1;

  final StreamController<Duration> inputDelayController =
      StreamController.broadcast();

  bool inputDelayed = false;
  bool enabled = true;

  @override
  void initState() {
    super.initState();
    inputController.initialize(
      correctString: widget.correctString,
      digits: widget.digits,
      onValidate: widget.onValidate,
    );

    inputController.verifyInput.listen((success) {
      if (success) {
        setState(() {
          enabled = false;
        });
        if (widget.correctString != null) {
          widget.onUnlocked!();
        } else {
          widget.onConfirmed!(inputController.confirmedInput);
        }
      } else {
        error();
        Future.delayed(const Duration(milliseconds: 300), () {
          inputController.clear();
        });
      }
    });

    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.onOpened?.call());
  }

  @override
  void didUpdateWidget(covariant ScreenLock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.inputController != widget.inputController) {
      inputController.dispose();
      inputController = widget.inputController ?? InputController();
    }
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  void inputDelay() {
    if (widget.retryDelay == (Duration.zero)) {
      return;
    }

    inputController.clear();
    DateTime unlockTime = DateTime.now().add(widget.retryDelay);
    inputDelayController.add(widget.retryDelay);

    setState(() {
      inputDelayed = true;
    });

    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      Duration difference = unlockTime.difference(DateTime.now());
      if (difference <= Duration.zero) {
        setState(() {
          inputDelayed = false;
        });
        timer.cancel();
      } else {
        inputDelayController.add(difference);
      }
    });
  }

  void error() {
    widget.onError?.call(retries);

    if (widget.maxRetries >= 1 && widget.maxRetries <= retries) {
      widget.onMaxRetries?.call(retries);
      retries = 0;
      inputDelay();
    }

    retries++;
  }

  Widget buildDelayChild(Duration duration) {
    if (widget.delayBuilder != null) {
      return widget.delayBuilder!(context, duration);
    } else {
      return Text(
        '${MyStrings.inputLockerFor.tr} ${(duration.inMilliseconds / 1000).ceil()} ${MyStrings.seconds}.',
      );
    }
  }

  Widget buildHeadingText() {
    Widget buildConfirmed(Widget child) {
      if (widget.correctString == null) {
        return StreamBuilder<bool>(
          stream: inputController.confirmed,
          builder: (context, snapshot) =>
              snapshot.data == true ? widget.confirmTitle! : child,
        );
      }
      return child;
    }

    Widget buildDelay(Widget child) {
      if (widget.retryDelay != (Duration.zero)) {
        return StreamBuilder<Duration>(
          stream: inputDelayController.stream,
          builder: (context, snapshot) {
            if (inputDelayed && snapshot.hasData) {
              return buildDelayChild(snapshot.data!);
            }
            return child;
          },
        );
      }
      return child;
    }

    return Builder(
      builder: (context) => DefaultTextStyle(
        style:mulishSemiBold.copyWith(fontSize: Dimensions.fontExtraLarge),
        textAlign: TextAlign.center,
        child: buildDelay(
          buildConfirmed(
            widget.title,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final orientations = <Orientation, Axis>{
      Orientation.portrait: Axis.vertical,
      Orientation.landscape:
          widget.useLandscape ? Axis.horizontal : Axis.vertical,
    };

    Widget buildSecrets() {
      if (widget.secretsBuilder != null) {
        return widget.secretsBuilder!(
          context,
          widget.secretsConfig,
          widget.digits,
          inputController.currentInput,
          inputController.verifyInput,
        );
      } else {
        return SecretsWithShakingAnimation(
          config: widget.secretsConfig,
          length: widget.digits,
          input: inputController.currentInput,
          verifyStream: inputController.verifyInput,
        );
      }
    }

    Widget buildKeyPad() {
      return Center(
        child: KeyPad(
          enabled: enabled && !inputDelayed,
          config: widget.keyPadConfig,
          inputState: inputController,
          didCancelled: widget.onCancelled,
          customizedButtonTap: widget.customizedButtonTap,
          customizedButtonChild: widget.customizedButtonChild,
          deleteButton: widget.deleteButton,
          cancelButton: widget.cancelButton,
        ),
      );
    }

    Widget buildContent() {
      return OrientationBuilder(
        builder: (context, orientation) => Container(
          color: MyColor.bgColor1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flex(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                direction: orientations[orientation]!,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildHeadingText(),
                      buildSecrets(),
                    ],
                  ),
                  buildKeyPad(),
                ],
              ),
              if (widget.footer != null) widget.footer!,
            ],
          ),
        ),
      );
    }

    Widget buildContentWithBlur({required bool useBlur}) {
      Widget child = buildContent();
      if (useBlur) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
          child: child,
        );
      }
      return child;
    }

    return Theme(
      data: (widget.config ?? ScreenLockConfig.defaultConfig).toThemeData(),
      child: Scaffold(
        body: SafeArea(
          child: buildContentWithBlur(useBlur: widget.useBlur),
        ),
      ),
    );
  }
}

typedef DelayBuilderCallback = Widget Function(
    BuildContext context, Duration delay);

typedef SecretsBuilderCallback = Widget Function(
  BuildContext context,
  SecretsConfig config,
  int length,
  ValueListenable<String> input,
  Stream<bool> verifyStream,
);

typedef ValidationCallback = Future<bool> Function(
  String input,
);
