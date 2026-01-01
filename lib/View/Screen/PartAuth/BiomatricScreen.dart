import 'dart:async';

import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/Utill/Local_User_Data.dart';
import 'package:core_project/helper/Route_Manager.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class BiomatricScreen extends StatefulWidget {
  const BiomatricScreen({Key? key}) : super(key: key);

  @override
  State<BiomatricScreen> createState() => _MyAppState();
}

class _MyAppState extends State<BiomatricScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  bool timerNeeded = false;
  Timer? _timer;
  int _start = 30;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timerNeeded = false;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );
  }

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      talker.error(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
      talker.info(availableBiometrics.contains(BiometricType.face));
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      talker.error(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  // Future<void> _authenticate() async {
  //   // this use biometrics or pin code
  //   bool authenticated = false;
  //   try {
  //     setState(() {
  //       _isAuthenticating = true;
  //       _authorized = 'Authenticating';
  //     });
  //     authenticated = await auth.authenticate(
  //       localizedReason: 'Let OS determine authentication method',
  //       options: const AuthenticationOptions(
  //         stickyAuth: true,
  //       ),
  //     );
  //     setState(() {
  //       _isAuthenticating = false;
  //     });
  //   } on PlatformException catch (e) {
  //     talker(e);
  //     setState(() {
  //       _isAuthenticating = false;
  //       _authorized = 'Error - ${e.message}';
  //     });
  //     return;
  //   }
  //   if (!mounted) {
  //     return;
  //   }
  //
  //   setState(
  //       () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
  // }

  Future<void> _authenticateWithBiometrics() async {
    if (timerNeeded == true) {
    }
    // only Biometrics
    else {
      bool authenticated = false;
      try {
        setState(() {
          _isAuthenticating = true;
          _authorized = 'Authenticating';
        });
        authenticated = await auth.authenticate(
          authMessages: [],
          localizedReason:
              'Scan your fingertalker to authenticate and Enter to Application',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ),
        );
        if (authenticated == true) {
          Navigator.pushReplacementNamed(context, Routes.tabBarRoute);
        }
        setState(() {
          _isAuthenticating = false;
          _authorized = 'Authenticating';
        });
      } on PlatformException catch (e) {
        talker.error(e);
        if (e.code == auth_error.biometricOnlyNotSupported) {
        } else {
          startTimer();
          setState(() {
            _isAuthenticating = false;
            timerNeeded = true;
          });
        }
        return;
      }
      if (!mounted) {
        return;
      }

      final String message = authenticated ? 'Authorized' : 'Not Authorized';
      setState(() {
        _authorized = message;
      });
    }
  }

  //
  // Future<void> _cancelAuthentication() async {
  //   await auth.stopAuthentication();
  //   setState(() => _isAuthenticating = false);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/topPart.png",
            height: 280,
            fit: BoxFit.cover,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 80),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Opacity(
          //         opacity: 0.05,
          //         child: Image.asset("assets/images/finegoldlogo.png",
          //             width: 150, height: 150, color: Colors.white),
          //       ),   Opacity(
          //         opacity: 0.05,
          //         child: Image.asset("assets/images/finegoldlogo.png",
          //             width: 150, height: 150, color: Colors.white),
          //       ),
          //     ],
          //   ),
          // ),
          ListView(
            padding: const EdgeInsets.only(top: 30),
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 150,
                  ),
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Image.asset(
                      "assets/images/finegoldlogo.png",
                      width: 100,
                      height: 100,
                    ),
                  ),
                  // if (_supportState == _SupportState.unknown)
                  //   const CircularProgressIndicator()
                  // else if (_supportState == _SupportState.supported)
                  //   const Text('This device is supported')
                  // else
                  //   const Text('This device is not supported'),
                  // const Divider(height: 100),
                  // Text('Can check biometrics: $_canCheckBiometrics\n'),
                  // ElevatedButton(
                  //   onPressed: _checkBiometrics,
                  //   child: const Text('Check biometrics'),
                  // ),
                  // const Divider(height: 100),
                  // Text('Available biometrics: $_availableBiometrics\n'),
                  // ElevatedButton(
                  //   onPressed: _getAvailableBiometrics,
                  //   child: const Text('Get available biometrics'),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${"Welcome".tr()} ${globalAccountData.getUsername()}",
                    style: const TextStyle(
                        color: BLACK,
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                        fontFamily: "headline1"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Use Biomatric tool",
                        // "${globalAccountData.getUsername()}",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0,
                            fontFamily: "NewFont",
                            letterSpacing: 1,
                            color: Colors.grey),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset(
                        "assets/images/pin.svg",
                        color: BLACK,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  timerNeeded == true
                      ? Text(
                          "you enter the fingertalker false 5 times \n you can try again after $_start sec",
                          textAlign: TextAlign.center,
                        )
                      : const SizedBox(
                          height: 10,
                        ),
                  const SizedBox(
                    height: 160,
                  ),
                  InkWell(
                    onTap: _authenticateWithBiometrics,
                    child: const Icon(Icons.fingerprint, size: 80, color: BLACK),
                  ),
                  timerNeeded == false
                      ? Text(
                          "Press to Authorized Dialog",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: BLACK),
                          textAlign: TextAlign.center,
                        )
                      : const SizedBox()
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
