import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/view/screens/lock_screen/widget/src/configurations/secrets_config.dart';
import 'package:local_coin/view/screens/lock_screen/widget/src/functions.dart';
import 'package:local_coin/view/screens/lock_screen/widget/src/input_controller.dart';
import 'package:local_coin/view/screens/lock_screen/widget/src/layout/secrets.dart';

import 'widget/src/screen_lock.dart';

class MyLockScreen extends StatefulWidget {
  const MyLockScreen({super.key});

  @override
  _MyLockScreenState createState() => _MyLockScreenState();
}

class _MyLockScreenState extends State<MyLockScreen> {
  Future<void> localAuth(BuildContext context) async {
    /*final localAuth = LocalAuthentication();
    final didAuthenticate = await localAuth.authenticate(
      localizedReason: 'Please authenticate',
      biometricOnly: true,
    );*/
   /* if (didAuthenticate) {
      Navigator.pop(context);
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        final controller = InputController();
        screenLockCreate(
          useBlur: false,
          context: context,
          inputController: controller,
          onConfirmed: (matchedText){
            print('matched text$matchedText');
                Navigator.of(context).pop();
          },
          footer: TextButton(
            onPressed: () {
              // Release the confirmation state and return to the initial input state.
              controller.unsetConfirmed();
            },
            child: const Text('Reset input'),
          ),
        );
        print('value = ${controller.confirmedInput.toString()}');
      },
      child: Scaffold(
        backgroundColor: MyColor.bgColor,
          body:ScreenLock(
      correctString: '1234',
      onCancelled: Navigator.of(context).pop,
      onUnlocked: Navigator.of(context).pop,
      )),
    );
  }
}

