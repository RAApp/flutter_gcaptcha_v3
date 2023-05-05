/*
 * Copyright (c) 2023.
 * Author: Jiten Basnet
 * Company: EB Pearls
 */

import 'package:dio/dio.dart';
import 'package:flutter_gcaptcha_v3/auth/data/models/verified_captcha_model.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';



class AuthRepositoryImpl  {
  AuthRepositoryImpl():_dio=Dio();

  final Dio _dio;

  Future<Either<String, VerifiedCaptchaModel>> verifyCaptcha(
      {required String secret, required String token}) async {
    try {
      final response = await _dio
          .post('https://www.google.com/recaptcha/api/siteverify', queryParameters: {'secret': secret, 'response': token});
      return right(VerifiedCaptchaModel.fromJson(response.data));
    } catch (e) {
      return left("Server Error");
    }
  }
}
