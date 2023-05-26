import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:quiz_app/services/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/contact_number.dart';
import '../data/models/response/response_model.dart';
import '../data/models/response/user_model.dart';
import '../data/repositories/auth_repo.dart';
import '../generated/assets.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool _acceptTerms = true;

  late final number = ContactNumber(number: '', countryCode: '+91');

  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  bool get isLoading => _isLoading;
  bool get acceptTerms => _acceptTerms;
  PageController pageController = PageController();

  Map<String, dynamic> data = {
    "se_name": null,
    "dr_name": null,
    "hq": null,
    "result": null,
    "q_one": null,
    "q_two": null,
    "q_three": null,
    "q_four": null,
  };
  TextEditingController oneController = TextEditingController();
  TextEditingController twoController = TextEditingController();
  TextEditingController threeController = TextEditingController();
  Map questionOneAnswer = {
    'answer': 2,
    'selected': null,
    'string': null,
  };

  Map questionTwoAnswer = {
    'answer': 4,
    'selected': null,
    'string': null,
  };
  Map questionThreeAnswer = {
    'answer': 1,
    'selected': null,
    'string': null,
  };
  Map questionFourAnswer = {
    'answer': 0,
    'selected': null,
    'string': null,
  };

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

  Future<bool> connectivity() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        log('connected');

        return true;
      }
    } on SocketException catch (_) {
      log('not connected');
      return false;
    }
    return false;
  }

  forwardButton() async {
    if (pageController.page! < images.length - 1 && validatePages()) {
      await pageController.animateToPage((pageController.page! + 1).round(), duration: const Duration(milliseconds: 50), curve: Curves.ease);
      update();
    }
    if (pageController.page!.round() == 6) {
      submitForm();
    }
  }

  bool validatePages() {
    if (pageController.page! == 0) {
      return true;
    } else if (pageController.page! == 1) {
      if (oneController.text.isValid && twoController.text.isValid && threeController.text.isValid) {
        return true;
      }
      Fluttertoast.showToast(msg: "Please enter all data");
      return false;
    } else if (pageController.page! == 2) {
      if (questionOneAnswer['selected'] != null && questionOneAnswer['string'] != null) {
        return true;
      }
      Fluttertoast.showToast(msg: "Please select an option");
      return false;
    } else if (pageController.page! == 3) {
      log('${questionTwoAnswer['string']}');
      if (questionTwoAnswer['selected'] != null && questionTwoAnswer['string'] != null) {
        return true;
      }
      Fluttertoast.showToast(msg: "Please select an option");
      return false;
    } else if (pageController.page! == 4) {
      if (questionThreeAnswer['selected'] != null && questionThreeAnswer['string'] != null) {
        return true;
      }
      Fluttertoast.showToast(msg: "Please select an option");
      return false;
    } else if (pageController.page! == 5) {
      if (questionFourAnswer['selected'] != null && questionFourAnswer['string'] != null) {
        return true;
      }
      Fluttertoast.showToast(msg: "Please select an option");
      return false;
    } else {
      return true;
    }
  }

  resetForm() async {
    await pageController.animateToPage(0, duration: const Duration(milliseconds: 50), curve: Curves.ease);
    oneController.clear();
    twoController.clear();
    threeController.clear();

    questionOneAnswer = {'answer': 2, 'selected': null};
    questionTwoAnswer = {'answer': 4, 'selected': null};
    questionThreeAnswer = {'answer': 1, 'selected': null};
    questionFourAnswer = {'answer': 0, 'selected': null};
    await pageController.animateToPage(0, duration: const Duration(milliseconds: 50), curve: Curves.ease);
    update();
  }

  int getScore() {
    int score = 1;
    if (questionOneAnswer['selected'] == questionOneAnswer['answer']) {
      score++;
    }
    if (questionTwoAnswer['selected'] == questionTwoAnswer['answer']) {
      score++;
    }
    if (questionThreeAnswer['selected'] == questionThreeAnswer['answer']) {
      score++;
    }
    return score;
  }

  submitForm() async {
    data['se_name'] = oneController.text;
    data['doctor_name'] = twoController.text;
    data['hq'] = threeController.text;
    data['result'] = getScore();
    data['q_one'] = questionOneAnswer['string'];
    data['q_two'] = questionTwoAnswer['string'];
    data['q_three'] = questionThreeAnswer['string'];
    data['q_four'] = questionFourAnswer['string'];
    if (await connectivity()) {
      //API CALL
      log(
        "$data",
        name: "DATA",
      );
      submitDa(data).then((value) {
        if (value.isSuccess) {
          // resetForm();
          Fluttertoast.showToast(msg: "Data saved to server");
        } else {
          SharedPreferences sharedPreferences = Get.find();
          sharedPreferences.clear();
          log('${sharedPreferences.getString('saved_data')}');
          List<dynamic> savedData = jsonDecode(sharedPreferences.getString('saved_data') ?? '[]');
          savedData.add(data);
          sharedPreferences.setString('saved_data', jsonEncode(savedData));
          // Fluttertoast.showToast(msg: "Data saved locally");
        }
      });
    } else {
      SharedPreferences sharedPreferences = Get.find();
      List<dynamic> savedData = jsonDecode(sharedPreferences.getString('saved_data') ?? '[]');
      savedData.add(data);
      sharedPreferences.setString('saved_data', jsonEncode(savedData));
      Fluttertoast.showToast(msg: "Data saved locally");
    }
  }

  Future<ResponseModel> submitDa(data) async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    try {
      Response response = await authRepo.submitDa(FormData(data));
      log(response.bodyString.toString(), name: 'submitDa()');
      if (response.statusCode == 200) {
        if (response.body.containsKey('errors')) {
          _isLoading = false;
          update();
          return ResponseModel(false, response.statusText!, response.body['errors']);
        }
        responseModel = ResponseModel(true, '${response.body}', response.body);
        _isLoading = false;
        update();
      } else {
        _isLoading = false;
        responseModel = ResponseModel(false, response.statusText!, response.body['errors']);
        update();
      }
    } catch (e) {
      _isLoading = false;
      update();
      responseModel = ResponseModel(false, "CATCH");
      log('++++++++ ${e.toString()} ++++++++', name: "ERROR AT submitDa()");
    }

    return responseModel;
  }

  syncData() async {
    if (await connectivity()) {
      SharedPreferences sharedPreferences = Get.find();
      List<dynamic> savedData = jsonDecode(sharedPreferences.getString('saved_data') ?? '[]');
      List remaining = [];
      if (savedData.isNotEmpty) {
        for (int i = 0; i < savedData.length; i++) {
          var element = savedData[i];
          log("$element");
          // if (false)
          submitDa(element).then((value) {
            if (value.isSuccess) {
              log("${value.isSuccess}");
              // savedData.removeAt(savedData.indexOf(element));
            } else {
              remaining.add(element);
            }
          });
        }

        Fluttertoast.showToast(msg: "Synced Successfully");
        sharedPreferences.setString('saved_data', jsonEncode(remaining));
      } else {
        Fluttertoast.showToast(msg: "Synced Successfully");
      }
    } else {
      Fluttertoast.showToast(msg: "Please connect to internet");
    }
  }

  void toggleTerms() {
    _acceptTerms = !_acceptTerms;
    update();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }

  void setUserToken(String id) {
    authRepo.saveUserToken(id);
  }
}
