import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../data/models/contact_number.dart';
import '../data/models/response/user_model.dart';
import '../data/repositories/auth_repo.dart';

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

  Map data = {};
  TextEditingController oneController = TextEditingController();
  TextEditingController twoController = TextEditingController();
  TextEditingController threeController = TextEditingController();
  Map questionOneAnswer = {
    'answer': 2,
    'selected': null,
  };

  Map questionTwoAnswer = {
    'answer': 4,
    'selected': null,
  };
  Map questionThreeAnswer = {
    'answer': 1,
    'selected': null,
  };
  Map questionFourAnswer = {
    'answer': 0,
    'selected': null,
  };

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
