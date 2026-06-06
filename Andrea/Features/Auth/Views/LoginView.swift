//
//  LoginView.swift
//  Andrea
//
//  Created by AlexGI on 05/06/2026.
//

import SwiftUI

struct LoginView: View {
    
    @State private var authViewModel: AuthViewModel = AuthViewModel()
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = true
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack{
                    ZStack{
                        Circle()
                            .fill(Color.appPrimary)
                            .frame(width: 120, height: 120)
                        Image(systemName: "heart.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }.padding(.bottom, 40)
                    
                    
                    
                    Text("Bienvenido")
                        .font(.largeTitle)
//                        .padding(.bottom, 0)
                    
                    Text("Encuentra tu match perfecto")
                        .font(.subheadline)
                        .fontWidth(.expanded)
                        .foregroundStyle(Color.secondary)
                        .padding(.bottom, 20)
                    
                    
                    CustomTextField(text: $email, hint: "Usuario o correo", icon: "person", keyboardType: .emailAddress)
                    
                    CustomProtectedTextField(text: $password, hint: "Contraseña")
                    
                    Button(action: {
                        rememberMe = !rememberMe
                    }, label: {
                        HStack {
                            Image(systemName: rememberMe ? "checkmark.square.fill" : "square")
                            Text("Recordarme")
                            Spacer()
                        }
                    })
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                    
//                    withAnimation {
                        if authViewModel.isLoading{
                            ProgressView()
                                .padding(.bottom, 20)
                        }
                        else{
                            withAnimation {
                                CustomButton(hint: "Iniciar sesión", action: {
                                    print(email)
                                    print(password)
                                    
                                    authViewModel.login(username: email, password: password, fcmToken: nil, deviceName: "Emulador prueba")
                                    
                                    print("LOGIN")
//                                    print(result)
                                })
                                .padding(.bottom, 20)
                            }
                        }
//                    }
                    
                    
                    Button(action: {},
                           label: {
                        Text("Olvidaste tu contraseña?")
                    }
                    )
                    .padding(.bottom, 30)
                    
                    HStack{
                        Text("No tienes cuenta?")
                            .foregroundStyle(Color.secondary)
                        NavigationLink("Registrate", value: AppDestination.register)
                    }
                    
                }
            }
            .navigationDestination(for: AppDestination.self){ destination in
                DestinationRouter.view(for: destination)
            }
        }
    }
}

#Preview {
    LoginView()
}
