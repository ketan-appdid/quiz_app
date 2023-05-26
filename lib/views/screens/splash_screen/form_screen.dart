import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:quiz_app/views/base/custom_image.dart';

import '../../../controllers/auth_controller.dart';
import '../../../services/input_decoration.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            Assets.imagesBg,
          ),
        ),
      ),
      child: GetBuilder<AuthController>(
        builder: (authController) {
          return Column(
            children: [
              const Spacer(
                flex: 4,
              ),
              SizedBox(
                width: size.width * .7,
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * .15,
                      child: const Text(
                        "SE Name",
                        style: TextStyle(
                          fontFamily: 'AgencyGothicCT',
                          fontSize: 40,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: authController.oneController,
                        decoration: CustomDecoration.inputDecoration(),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: size.width * .7,
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * .15,
                      child: const Text(
                        "DR Name",
                        style: TextStyle(
                          fontFamily: 'AgencyGothicCT',
                          fontSize: 40,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: authController.twoController,
                        decoration: CustomDecoration.inputDecoration(),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: size.width * .7,
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * .15,
                      child: const Text(
                        "HQ",
                        style: TextStyle(
                          fontFamily: 'AgencyGothicCT',
                          fontSize: 40,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: authController.threeController,
                        decoration: CustomDecoration.inputDecoration(),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 12),
            ],
          );
        },
      ),
    );
  }
}
