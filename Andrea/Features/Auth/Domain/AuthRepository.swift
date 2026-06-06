//
//  AuthRepository.swift
//  Andrea
//
//  Created by AlexGI on 06/06/2026.
//

import Foundation

protocol AuthRepository {
    func login(username: String, password: String, fcmToken: String?, deviceName: String) async throws -> AuthResponse
    func register(name: String, email: String, username: String, password: String, phone: String, country: String?, birthdate: Date, genderIdentity: Int, genderPreference: Int) async throws
}


/*
import 'package:andrea/config/helpers/custom_response.dart';

abstract class AuthRemoteRepository {
  Future<CustomResponse<void>> forgotPassword({required String username});

  Future<CustomResponse<void>> resetPassword(
      {required String username,
      required String password,
      required String code});

  Future<CustomResponse<void>> resend({required String username});
  Future<CustomResponse<bool>> verifyDataRegister({required String data});

  Future<CustomResponse<void>> verify(
      {required String email, required String code});

  // Google Auth
  Future<CustomResponse<Map<String, dynamic>>> googleLogin({
    required String googleToken,
    String? fcmToken,
    required String deviceName,
  });

  Future<CustomResponse<Map<String, dynamic>>> googleRegister({
    required String googleToken,
    required String name,
    required String email,
    required String username,
    required String phone,
    required int genderIdentity,
    required int genderPreference,
    required DateTime birthdate,
    String? country,
    String? fcmToken,
    required String deviceName,
  });
}
*/
