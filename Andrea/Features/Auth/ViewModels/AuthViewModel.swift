//
//  AuthViewModel.swift
//  Andrea
//
//  Created by AlexGI on 05/06/2026.
//
import Foundation

@MainActor
@Observable
class AuthViewModel {
    private var repo : AuthRepository = AuthRepositoryImpl()
    
    var isLoading: Bool = false
    var isLoadingCountries: Bool = false
    var countries: [Country] = []
    
    
    func login(username: String, password: String, fcmToken: String?, deviceName: String) {
        Task{
            do {
                isLoading = true
                
                let response = try await repo.login(username: username, password: password, fcmToken: fcmToken, deviceName: deviceName)
                if let token = response.token {
                    AuthManager.shared.login(token: token)
                } else {
                    throw URLError(.userAuthenticationRequired)
                }
                
            } catch {
                print(error)
            }
                
            isLoading = false
        }
    }
    
    func register(name: String, email: String, username: String, password: String, phone: String,  country: String?, birthdate: Date, genderIdentity: Int, genderPreference: Int) {
        Task{
            do {
                isLoading = true
                
                let _ = try await repo.register(name: name, email: email, username: username, password: password, phone: phone, country: country, birthdate: birthdate, genderIdentity: genderIdentity, genderPreference: genderPreference)
            
//                AuthManager.shared.login(token: response.token)
                
            } catch {
                print(error)
            }
                
            isLoading = false
        }
    }
    
    func getCountries() {
        if let url = Bundle.main.url(forResource: "countries", withExtension: "json") {
            do {
                isLoadingCountries = true
                
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                countries = try decoder.decode([Country].self, from: data)
//                print(c)
            } catch {
                print("Error al decodificar el JSON: \(error)")
            }
            
            isLoadingCountries = false
        }
    }
}
