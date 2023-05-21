import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import '../../../controllers/auth_controller.dart';
import '../../../services/input_decoration.dart';
import '../../base/custom_image.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer.run(() {
      Future.delayed(const Duration(seconds: 2), () {});
    });
  }

  Map data = {};

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<String> images = [
      Assets.images1,
      Assets.images2,
      Assets.images3,
      Assets.images5,
      Assets.images7,
      Assets.images9,
      Assets.images11,
      Assets.images12,
    ];
    return Scaffold(
      body: GetBuilder<AuthController>(builder: (authController) {
        return SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              PageView.builder(
                controller: authController.pageController,
                itemCount: images.length,
                onPageChanged: (va) {
                  log("${authController.pageController.page}");
                },
                itemBuilder: (BuildContext context, int index) {
                  return CustomImage(
                    path: images[index],
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
              if (authController.pageController.hasClients)
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
                  ),
              if (authController.pageController.hasClients)
                if (authController.pageController.page?.round() == 0)
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: GestureDetector(
                      onTap: () {},
                      child: const CustomImage(
                        path: Assets.imagesSyncBlue,
                        height: 75,
                        width: 75,
                      ),
                    ),
                  ),
              if (authController.pageController.hasClients)
                if (authController.pageController.page?.round() != 0)
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
              Positioned(
                bottom: 20,
                right: 20,
                child: GestureDetector(
                  onTap: () async {
                    if (authController.pageController.page! < images.length) {
                      await authController.pageController
                          .animateToPage((authController.pageController.page! + 1).round(), duration: const Duration(milliseconds: 50), curve: Curves.ease);
                      setState(() {});
                    }
                  },
                  child: const CustomImage(
                    path: Assets.imagesForwardBlue,
                    height: 75,
                    width: 75,
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
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: onTap,
        child: Ink(
          color: color,
          height: height,
          width: width,
        ),
      ),
    );
  }
}

class QuestionOne extends StatelessWidget {
  const QuestionOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<AuthController>(builder: (authController) {
      bool isSelected() {
        return authController.questionOneAnswer['selected'] != null;
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
        top: size.height * .265,
        // left: size.width * .4,
        width: size.width,
        child: Material(
          color: Colors.transparent,
          elevation: 0,
          child: Column(
            children: [
              OptionButton(
                height: size.height * .08,
                width: size.width * .2,
                color: getColorIfSelected(1),
                onTap: () {
                  authController.questionOneAnswer['selected'] = 1;
                  authController.update();
                },
              ),
              OptionButton(
                height: size.height * .08,
                width: size.width * .2,
                color: getColorIfSelected(2),
                onTap: () {
                  authController.questionOneAnswer['selected'] = 2;
                  authController.update();
                },
              ),
              OptionButton(
                height: size.height * .08,
                width: size.width * .2,
                color: getColorIfSelected(3),
                onTap: () {
                  authController.questionOneAnswer['selected'] = 3;
                  authController.update();
                },
              ),
              OptionButton(
                height: size.height * .08,
                width: size.width * .2,
                color: getColorIfSelected(4),
                onTap: () {
                  authController.questionOneAnswer['selected'] = 4;
                  authController.update();
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}

class QuestionTwo extends StatelessWidget {
  const QuestionTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<AuthController>(builder: (authController) {
      bool isSelected() {
        return authController.questionTwoAnswer['selected'] != null;
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
        top: size.height * .265,
        // left: size.width * .4,
        width: size.width,
        child: Material(
          color: Colors.transparent,
          elevation: 0,
          child: Column(
            children: [
              OptionButton(
                height: size.height * .08,
                width: size.width * .55,
                color: getColorIfSelected(1),
                onTap: () {
                  authController.questionTwoAnswer['selected'] = 1;
                  authController.update();
                },
              ),
              OptionButton(
                height: size.height * .08,
                width: size.width * .55,
                color: getColorIfSelected(2),
                onTap: () {
                  authController.questionTwoAnswer['selected'] = 2;
                  authController.update();
                },
              ),
              OptionButton(
                height: size.height * .08,
                width: size.width * .55,
                color: getColorIfSelected(3),
                onTap: () {
                  authController.questionTwoAnswer['selected'] = 3;
                  authController.update();
                },
              ),
              OptionButton(
                height: size.height * .08,
                width: size.width * .55,
                color: getColorIfSelected(4),
                onTap: () {
                  authController.questionTwoAnswer['selected'] = 4;
                  authController.update();
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}

class QuestionThree extends StatelessWidget {
  const QuestionThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<AuthController>(builder: (authController) {
      bool isSelected() {
        return authController.questionThreeAnswer['selected'] != null;
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
        top: size.height * .265,
        // left: size.width * .4,
        width: size.width,
        child: Material(
          color: Colors.transparent,
          elevation: 0,
          child: Column(
            children: [
              OptionButton(
                height: size.height * .08,
                width: size.width * .55,
                color: getColorIfSelected(1),
                onTap: () {
                  authController.questionThreeAnswer['selected'] = 1;
                  authController.update();
                },
              ),
              OptionButton(
                height: size.height * .08,
                width: size.width * .55,
                color: getColorIfSelected(2),
                onTap: () {
                  authController.questionThreeAnswer['selected'] = 2;
                  authController.update();
                },
              ),
              OptionButton(
                height: size.height * .08,
                width: size.width * .55,
                color: getColorIfSelected(3),
                onTap: () {
                  authController.questionThreeAnswer['selected'] = 3;
                  authController.update();
                },
              ),
              OptionButton(
                height: size.height * .08,
                width: size.width * .55,
                color: getColorIfSelected(4),
                onTap: () {
                  authController.questionThreeAnswer['selected'] = 4;
                  authController.update();
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}

class QuestionFour extends StatelessWidget {
  const QuestionFour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<AuthController>(builder: (authController) {
      bool isSelected() {
        return authController.questionFourAnswer['selected'] != null;
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
        top: size.height * .265,
        // left: size.width * .4,
        width: size.width,
        child: Material(
          color: Colors.transparent,
          elevation: 0,
          child: Column(
            children: [
              OptionButton(
                height: size.height * .08,
                width: size.width * .9,
                color: getColorIfSelected(1),
                onTap: () {
                  authController.questionFourAnswer['selected'] = 1;
                  authController.update();
                },
              ),
              OptionButton(
                height: size.height * .08,
                width: size.width * .9,
                color: getColorIfSelected(2),
                onTap: () {
                  authController.questionFourAnswer['selected'] = 2;
                  authController.update();
                },
              ),
              OptionButton(
                height: size.height * .08,
                width: size.width * .9,
                color: getColorIfSelected(3),
                onTap: () {
                  authController.questionFourAnswer['selected'] = 3;
                  authController.update();
                },
              ),
              OptionButton(
                height: size.height * .08,
                width: size.width * .9,
                color: getColorIfSelected(4),
                onTap: () {
                  authController.questionFourAnswer['selected'] = 4;
                  authController.update();
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
