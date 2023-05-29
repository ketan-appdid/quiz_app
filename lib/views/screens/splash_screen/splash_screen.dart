import 'dart:async';
import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';

import '../../../controllers/auth_controller.dart';
import '../../base/custom_image.dart';
import 'form_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer.run(() async {
      await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {});
      });
    });
  }

  Map data = {};

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<AuthController>(builder: (authController) {
        return SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: authController.pageController,
                itemCount: authController.images.length,
                onPageChanged: (va) {
                  log("${authController.pageController.page}");
                },
                itemBuilder: (BuildContext context, int index) {
                  if (index == 1) {
                    return const FormScreen();
                  }
                  return CustomImage(
                    path: authController.images[index],
                    width: size.width,
                    height: size.height,
                  );
                },
              ),
              if (authController.pageController.hasClients)
                if (authController.pageController.page == 2) const QuestionOne(),
              if (authController.pageController.hasClients)
                if (authController.pageController.page == 3) const QuestionTwo(),
              if (authController.pageController.hasClients)
                if (authController.pageController.page == 4) const QuestionThree(),
              if (authController.pageController.hasClients)
                if (authController.pageController.page == 5) const QuestionFour(),
              /*if (authController.pageController.hasClients)
                if (authController.pageController.page?.toInt() == 1)
                  Positioned(
                    top: size.height * .14,
                    left: size.width * .333,
                    child: SizedBox(
                      height: size.height * .0654,
                      width: size.width * .507,
                      child: TextFormField(
                        controller: authController.oneController,
                        decoration: CustomDecoration.inputDecoration(),
                      ),
                    ),
                  ),
              if (authController.pageController.hasClients)
                if (authController.pageController.page?.toInt() == 1)
                  Positioned(
                    top: size.height * .32,
                    left: size.width * .333,
                    child: SizedBox(
                      height: size.height * .0654,
                      width: size.width * .507,
                      child: TextFormField(
                        controller: authController.twoController,
                        decoration: CustomDecoration.inputDecoration(),
                      ),
                    ),
                  ),
              if (authController.pageController.hasClients)
                if (authController.pageController.page?.round() == 1)
                  Positioned(
                    top: size.height * .498,
                    left: size.width * .333,
                    child: SizedBox(
                      height: size.height * .0654,
                      width: size.width * .507,
                      child: TextFormField(
                        controller: authController.threeController,
                        decoration: CustomDecoration.inputDecoration(),
                      ),
                    ),
                  ),*/
              // Sync Button
              if (authController.pageController.hasClients)
                if (authController.pageController.page?.round() == 0)
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: GestureDetector(
                      onTap: () async {
                        await authController.syncData();
                      },
                      child: const CustomImage(
                        path: Assets.imagesSyncBlue,
                        height: 75,
                        width: 75,
                      ),
                    ),
                  ),
              // Back Button
              if (authController.pageController.hasClients)
                if (authController.pageController.page!.round() < 6 && authController.pageController.page!.round() > 0)
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: GestureDetector(
                      onTap: () async {
                        if (authController.pageController.page! > 0) {
                          await authController.pageController
                              .animateToPage((authController.pageController.page! - 1).round(), duration: const Duration(milliseconds: 50), curve: Curves.ease);
                          setState(() {});
                        }
                      },
                      child: const CustomImage(
                        path: Assets.imagesBackwardBlue,
                        height: 75,
                        width: 75,
                      ),
                    ),
                  ),
              // Forward Button
              if (authController.pageController.hasClients)
                if (authController.pageController.page?.round() != authController.images.length - 1)
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: GestureDetector(
                      onTap: () async {
                        authController.forwardButton();
                      },
                      child: const CustomImage(
                        path: Assets.imagesForwardBlue,
                        height: 75,
                        width: 75,
                      ),
                    ),
                  ),
              // Home Button
              if (authController.pageController.hasClients)
                if (authController.pageController.page!.round() > 0)
                  Positioned(
                    top: 40,
                    right: 30,
                    child: GestureDetector(
                      onTap: () async {
                        authController.resetForm();
                      },
                      child: CustomImage(
                        path: (authController.pageController.page!.round() < authController.images.length - 1) ? Assets.imagesHomeBrown : Assets.imagesHomeBlue,
                        height: 60,
                        width: 60,
                      ),
                    ),
                  ),
            ],
          ),
        );
      }),
    );
  }
}

class OptionButton extends StatelessWidget {
  const OptionButton({
    Key? key,
    required this.height,
    required this.width,
    required this.onTap,
    this.color = Colors.transparent,
  }) : super(key: key);

  final double height;
  final double width;
  final Function() onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: InkWell(
        onTap: onTap,
        child: Ink(
          color: /*Colors.blue.withOpacity(.5) ??*/ color,
          height: height,
          width: width,
        ),
      ),
    );
  }
}

class QuestionOne extends StatefulWidget {
  const QuestionOne({Key? key}) : super(key: key);

  @override
  State<QuestionOne> createState() => _QuestionOneState();
}

class _QuestionOneState extends State<QuestionOne> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  bool _isInit = true;

  // AssetsAudioPlayer.newPlayer().open(
  // Audio("assets/audios/correct_selection.mp3"),
  // showNotification: false,
  // );

  // AssetsAudioPlayer.newPlayer().open(
  // Audio("assets/audios/invalid_selection.mp3"),
  // showNotification: false,
  // );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<AuthController>(builder: (authController) {
      bool isSelected() {
        return authController.questionOneAnswer['selected'] != null;
      }

      if (!_isInit) {
        if (authController.questionOneAnswer['selected'] == authController.questionOneAnswer['answer']) {
          AssetsAudioPlayer.newPlayer().open(
            Audio("assets/audios/correct_selection.mp3"),
            showNotification: false,
          );
        } else {
          AssetsAudioPlayer.newPlayer().open(
            Audio("assets/audios/invalid_selection.mp3"),
            showNotification: false,
          );
        }
      } else {
        _isInit = false;
      }

      Color getColorIfSelected(int index) {
        var data = authController.questionOneAnswer;
        if (isSelected()) {
          if (index == data['answer']) {
            return Colors.green.withOpacity(.5);
          } else if (data['selected'] == index) {
            return Colors.red.withOpacity(.5);
          }
          return Colors.transparent;
        } else {
          return Colors.transparent;
        }
      }

      return Positioned(
        top: size.height * .278,
        // left: size.width * .4,
        width: size.width,
        child: Material(
          color: Colors.transparent,
          elevation: 0,
          child: Column(
            children: [
              OptionButton(
                height: size.height * .075,
                width: size.width * .2,
                color: getColorIfSelected(1),
                onTap: () {
                  authController.questionOneAnswer['selected'] = 1;
                  authController.questionOneAnswer['string'] = '1990';

                  authController.update();
                },
              ),
              const SizedBox(height: 13),
              OptionButton(
                height: size.height * .075,
                width: size.width * .2,
                color: getColorIfSelected(2),
                onTap: () {
                  authController.questionOneAnswer['selected'] = 2;
                  authController.questionOneAnswer['string'] = '1998';
                  authController.update();
                },
              ),
              const SizedBox(height: 15),
              OptionButton(
                height: size.height * .075,
                width: size.width * .2,
                color: getColorIfSelected(3),
                onTap: () {
                  authController.questionOneAnswer['selected'] = 3;
                  authController.questionOneAnswer['string'] = '1999';
                  authController.update();
                },
              ),
              const SizedBox(height: 14),
              OptionButton(
                height: size.height * .075,
                width: size.width * .2,
                color: getColorIfSelected(4),
                onTap: () {
                  authController.questionOneAnswer['selected'] = 4;
                  authController.questionOneAnswer['string'] = '2000';

                  authController.update();
                },
              ),
              if (isSelected()) const SizedBox(height: 70),
              if (isSelected())
                const CustomImage(
                  path: Assets.images4,
                  // width: size.width * .7,
                  height: 40,
                ),
            ],
          ),
        ),
      );
    });
  }
}

class QuestionTwo extends StatefulWidget {
  const QuestionTwo({Key? key}) : super(key: key);

  @override
  State<QuestionTwo> createState() => _QuestionTwoState();
}

class _QuestionTwoState extends State<QuestionTwo> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  bool _isInit = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<AuthController>(builder: (authController) {
      bool isSelected() {
        return authController.questionTwoAnswer['selected'] != null;
      }

      if (!_isInit) {
        if (authController.questionTwoAnswer['selected'] == authController.questionTwoAnswer['answer']) {
          AssetsAudioPlayer.newPlayer().open(
            Audio("assets/audios/correct_selection.mp3"),
            showNotification: false,
          );
        } else {
          AssetsAudioPlayer.newPlayer().open(
            Audio("assets/audios/invalid_selection.mp3"),
            showNotification: false,
          );
        }
      } else {
        _isInit = false;
      }

      Color getColorIfSelected(int index) {
        var data = authController.questionTwoAnswer;
        if (isSelected()) {
          if (index == data['answer']) {
            return Colors.green.withOpacity(.5);
          } else if (data['selected'] == index) {
            return Colors.red.withOpacity(.5);
          }
          return Colors.transparent;
        } else {
          return Colors.transparent;
        }
      }

      return Positioned(
        top: size.height * .278,
        // left: size.width * .4,
        width: size.width,
        child: Material(
          color: Colors.transparent,
          elevation: 0,
          child: Column(
            children: [
              OptionButton(
                height: size.height * .075,
                width: size.width * .55,
                color: getColorIfSelected(1),
                onTap: () {
                  authController.questionTwoAnswer['selected'] = 1;
                  authController.questionTwoAnswer['string'] = 'Reservoir matrix system';
                  authController.update();
                },
              ),
              const SizedBox(height: 13),
              OptionButton(
                height: size.height * .075,
                width: size.width * .55,
                color: getColorIfSelected(2),
                onTap: () {
                  authController.questionTwoAnswer['selected'] = 2;
                  authController.questionTwoAnswer['string'] = 'Nano crystalline technology';
                  authController.update();
                },
              ),
              const SizedBox(height: 15),
              OptionButton(
                height: size.height * .075,
                width: size.width * .55,
                color: getColorIfSelected(3),
                onTap: () {
                  authController.questionTwoAnswer['selected'] = 3;
                  authController.questionTwoAnswer['string'] = 'Easy release technology';
                  authController.update();
                },
              ),
              const SizedBox(height: 14),
              OptionButton(
                height: size.height * .075,
                width: size.width * .55,
                color: getColorIfSelected(4),
                onTap: () {
                  authController.questionTwoAnswer['selected'] = 4;
                  authController.questionTwoAnswer['string'] = 'Micro encapsulation technology';
                  authController.update();
                },
              ),
              if (isSelected()) const SizedBox(height: 70),
              if (isSelected())
                const CustomImage(
                  path: Assets.images6,
                  // width: size.width * .7,
                  height: 40,
                ),
            ],
          ),
        ),
      );
    });
  }
}

class QuestionThree extends StatefulWidget {
  const QuestionThree({Key? key}) : super(key: key);

  @override
  State<QuestionThree> createState() => _QuestionThreeState();
}

class _QuestionThreeState extends State<QuestionThree> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  bool _isInit = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<AuthController>(builder: (authController) {
      bool isSelected() {
        return authController.questionThreeAnswer['selected'] != null;
      }

      if (!_isInit) {
        if (authController.questionThreeAnswer['selected'] == authController.questionThreeAnswer['answer']) {
          AssetsAudioPlayer.newPlayer().open(
            Audio("assets/audios/correct_selection.mp3"),
            showNotification: false,
          );
        } else {
          AssetsAudioPlayer.newPlayer().open(
            Audio("assets/audios/invalid_selection.mp3"),
            showNotification: false,
          );
        }
      } else {
        _isInit = false;
      }

      Color getColorIfSelected(int index) {
        var data = authController.questionThreeAnswer;
        if (isSelected()) {
          if (index == data['answer']) {
            return Colors.green.withOpacity(.5);
          } else if (data['selected'] == index) {
            return Colors.red.withOpacity(.5);
          }
          return Colors.transparent;
        } else {
          return Colors.transparent;
        }
      }

      return Positioned(
        top: size.height * .278,
        // left: size.width * .4,
        width: size.width,
        child: Material(
          color: Colors.transparent,
          elevation: 0,
          child: Column(
            children: [
              OptionButton(
                height: size.height * .075,
                width: size.width * .55,
                color: getColorIfSelected(1),
                onTap: () {
                  authController.questionThreeAnswer['selected'] = 1;
                  authController.questionThreeAnswer['string'] = 'Diluent in prefilled syringe';

                  authController.update();
                },
              ),
              const SizedBox(height: 13),
              OptionButton(
                height: size.height * .075,
                width: size.width * .55,
                color: getColorIfSelected(2),
                onTap: () {
                  authController.questionThreeAnswer['selected'] = 2;
                  authController.questionThreeAnswer['string'] = 'Tourniquet belt';
                  authController.update();
                },
              ),
              const SizedBox(height: 15),
              OptionButton(
                height: size.height * .075,
                width: size.width * .55,
                color: getColorIfSelected(3),
                onTap: () {
                  authController.questionThreeAnswer['selected'] = 3;
                  authController.questionThreeAnswer['string'] = 'Gloves';
                  authController.update();
                },
              ),
              const SizedBox(height: 14),
              OptionButton(
                height: size.height * .075,
                width: size.width * .55,
                color: getColorIfSelected(4),
                onTap: () {
                  authController.questionThreeAnswer['selected'] = 4;
                  authController.questionThreeAnswer['string'] = 'Iniection plaster';
                  authController.update();
                },
              ),
              if (isSelected()) const SizedBox(height: 70),
              if (isSelected())
                const CustomImage(
                  path: Assets.images8,
                  // width: size.width * .7,
                  height: 40,
                ),
            ],
          ),
        ),
      );
    });
  }
}

class QuestionFour extends StatefulWidget {
  const QuestionFour({Key? key}) : super(key: key);

  @override
  State<QuestionFour> createState() => _QuestionFourState();
}

class _QuestionFourState extends State<QuestionFour> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  bool _isInit = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<AuthController>(builder: (authController) {
      bool isSelected() {
        return authController.questionFourAnswer['selected'] != null;
      }

      if (!_isInit) {
        AssetsAudioPlayer.newPlayer().open(
          Audio("assets/audios/correct_selection.mp3"),
          showNotification: false,
        );
      } else {
        _isInit = false;
      }

      Color getColorIfSelected(int index) {
        var data = authController.questionFourAnswer;
        if (isSelected()) {
          return Colors.green.withOpacity(.5);
          if (index == data['answer']) {
            return Colors.green.withOpacity(.5);
          } else if (data['selected'] == index) {
            return Colors.red.withOpacity(.5);
          }
          return Colors.transparent;
        } else {
          return Colors.transparent;
        }
      }

      return Positioned(
        top: size.height * .278,
        // left: size.width * .4,
        width: size.width,
        child: Material(
          color: Colors.transparent,
          elevation: 0,
          child: Column(
            children: [
              OptionButton(
                height: size.height * .075,
                width: size.width * .9,
                color: getColorIfSelected(1),
                onTap: () {
                  authController.questionFourAnswer['selected'] = 1;
                  authController.questionFourAnswer['string'] = 'Manufacturing in CGMP conditions';

                  authController.update();
                },
              ),
              const SizedBox(height: 13),
              OptionButton(
                height: size.height * .075,
                width: size.width * .9,
                color: getColorIfSelected(2),
                onTap: () {
                  authController.questionFourAnswer['selected'] = 2;
                  authController.questionFourAnswer['string'] = 'Technical expertise to produce active peptide polymerin';

                  authController.update();
                },
              ),
              const SizedBox(height: 15),
              OptionButton(
                height: size.height * .075,
                width: size.width * .9,
                color: getColorIfSelected(3),
                onTap: () {
                  authController.questionFourAnswer['selected'] = 3;
                  authController.questionFourAnswer['string'] = 'In-house production of raw materials';

                  authController.update();
                },
              ),
              const SizedBox(height: 14),
              OptionButton(
                height: size.height * .075,
                width: size.width * .9,
                color: getColorIfSelected(4),
                onTap: () {
                  authController.questionFourAnswer['selected'] = 4;
                  authController.questionFourAnswer['string'] = 'Every batch tested for pre-clinical efficacy';

                  authController.update();
                },
              ),
              if (isSelected()) const SizedBox(height: 70),
              if (isSelected())
                const CustomImage(
                  path: Assets.images10,
                  // width: size.width * .7,
                  height: 40,
                ),
            ],
          ),
        ),
      );
    });
  }
}
