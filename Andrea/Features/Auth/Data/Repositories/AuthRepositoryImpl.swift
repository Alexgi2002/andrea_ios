//
//  AuthRepositoryImpl.swift
//  Andrea
//
//  Created by AlexGI on 06/06/2026.
//

import Foundation

class AuthRepositoryImpl: AuthRepository{
    private let apiClient = APIClient.shared
    
    private let path = "auth"
    
    func login(username: String, password: String, fcmToken: String?, deviceName: String) async throws -> AuthResponse {
        let body = LoginDTO(identifier: username, password: password, fcm_token: fcmToken, device_name: deviceName)
        let data = try await apiClient.postData(from: path + "/login", body: body, responseType: AuthResponse.self)
        
        return data
    }
    
    func register(name: String, email: String, username: String, password: String, phone: String, country: String?, birthdate: Date, genderIdentity: Int, genderPreference: Int) async throws  {
        
    }
}


/*
 @override
   Future<CustomResponse<Map<String, dynamic>>> login(
       {required String username,
       required String password,
       String? fcmToken,
       required String deviceName,
     }) async {
     try {
       final response = await _myDio.request(
           requestType: RequestType.POST,
           path: "$path/login",
           data: {
             'identifier': username,
             'password': password,
             'fcm_token': fcmToken,
             'device_name': deviceName,
           });

       final String? accesToken = response["data"]["token"];
       if (accesToken != null) {
         Prefs.instance.saveValue(ConstantsSharedPrefs.accessToken, accesToken);
         _myDio.updateToken(accesToken);
       }
       return CustomResponse<Map<String, dynamic>>(
           data: response, statusCode: 200);
     } on CustomDioError catch (_) {
       rethrow;
     } catch (e) {
       throw CustomDioError(code: 400);
     }
   }

   @override
   Future<CustomResponse<void>> register({
     required String name,
     required String email,
     required String username,
     required String phone,
     required int genderIdentity,
     required int genderPreference,
     required DateTime birthdate,
     required String password,
     String? country,
   }) async {
     try {
       final response = await _myDio.request(
           requestType: RequestType.POST,
           path: "$path/register",
           data: {
             'name': name,
             'email': email,
             'username': username,
             'phone': phone,
             'genderIdentity': genderIdentity,
             'genderPreference': genderPreference,
             'birthdate': birthdate.millisecondsSinceEpoch,
             'password': password,
             'country': country,
           });
       final Map<String, dynamic>? data = response["data"];
       final String? accesToken = data?["token"];
       if (accesToken != null) {
         Prefs.instance.saveValue(ConstantsSharedPrefs.accessToken, accesToken);
         _myDio.updateToken(accesToken);
       }
       return CustomResponse<Map<String, dynamic>>(
           data: response, statusCode: 200);
     } on CustomDioError catch (_) {
       rethrow;
     } catch (e) {
       throw CustomDioError(code: 400);
     }
   }
 */
