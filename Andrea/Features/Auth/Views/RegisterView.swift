//
//  RegisterView.swift
//  Andrea
//
//  Created by AlexGI on 05/06/2026.
//

import SwiftUI
import MapKit // Se mantiene por si se usa en el futuro, aunque no es directamente necesario para esta actualización

// Definición del Enum solicitado
enum Gender: Int, CaseIterable, Identifiable {
    case masculino = 0
    case femenino = 1
    case noBinarioOOtro = 2
    
    var description: String {
        switch self {
        case .masculino: return "Masculino"
        case .femenino: return "Femenino"
        case .noBinarioOOtro: return "No binario / Otro"
        }
    }
    
    var id: Self { self }
}

struct RegisterView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var authViewModel: AuthViewModel = AuthViewModel()
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var phone: String = ""
    @State private var country: Country?
    
    @State private var birthdate: Date = Date()
    let dateRange: ClosedRange<Date> = {
        let today = Date()
        let calendar = Calendar.current
        // Máximo: Hace 18 años (La persona más joven permitida)
        let dateMax = calendar.date(byAdding: .year, value: -18, to: today) ?? today
        // Mínimo: Hace 100 años (La persona más vieja permitida)
        let dateMin = calendar.date(byAdding: .year, value: -100, to: today) ?? today
        
        return dateMin...dateMax
    }()
    
    @State private var genderIdentity: Int = Gender.masculino.rawValue
    @State private var genderPreference: Int = Gender.femenino.rawValue

    var body: some View {
//        NavigationStack {
            ScrollView {
                VStack {
                    
                    // Título similar al login
                    Text("Regístrate")
                        .font(.largeTitle)
                        .bold()
                    
                    Text("Crea tu cuenta hoy")
                        .font(.subheadline)
                        .fontWidth(.expanded)
                        .foregroundStyle(Color.secondary)
                        .padding(.bottom, 20)

                    CustomTextField(text: $name, hint: "Nombre completo", icon: "person", keyboardType: .namePhonePad)
                    
                    CustomTextField(text: $email, hint: "Correo Electrónico", icon: "envelope", keyboardType: .emailAddress)

                    CustomTextField(text: $username, hint: "Nombre de usuario", icon: "at", keyboardType: .namePhonePad)
                    
                    CustomProtectedTextField(text: $password, hint: "Contraseña")
                    
                    CustomProtectedTextField(text: $confirmPassword, hint: "Confirmar contraseña")
                    
                    if authViewModel.isLoadingCountries{
                        ProgressView()
                    }
                    else if authViewModel.countries.isEmpty {
                        EmptyView()
                    }
                    else {
                        Picker("Seleccione su país", selection: $country) {
                            ForEach(authViewModel.countries, id: \.self) { c in
                                HStack{
                                    Text("\(c.emoji ?? c.code)")
                                    Text(c.name)
                                }.tag(c)
                            }
                        }
                        .pickerStyle(.navigationLink)
                        .padding(.horizontal)
                        .labelsVisibility(.visible)
                    }

                    CustomTextField(text: $phone, hint: "Teléfono", leadingText: country?.area_code, icon: "phone", keyboardType: .phonePad)

                    Text("Fecha de Nacimiento")
                    DatePicker("", selection: $birthdate, in: dateRange, displayedComponents: [.date])
                        .labelsHidden()
                        .datePickerStyle(.wheel)
                        .padding(.horizontal)

                    HStack{
                        Text("Género Identidad:")
                        Spacer()
                        Picker("Identidad", selection: $genderIdentity) {
                            Text(Gender.masculino.description).tag(Gender.masculino.rawValue)
                            Text(Gender.femenino.description).tag(Gender.femenino.rawValue)
                            Text(Gender.noBinarioOOtro.description).tag(Gender.noBinarioOOtro.rawValue)
                        }
                        .pickerStyle(.menu)
                        .labelsHidden()
                        
                    }
//                    .padding()
                    .padding(.horizontal)
                    
                    HStack{
                        Text("Género que te gusta:")
                        Spacer()
                        Picker("Gusto", selection: $genderPreference) {
                            Text(Gender.masculino.description).tag(Gender.masculino.rawValue)
                            Text(Gender.femenino.description).tag(Gender.femenino.rawValue)
                            Text(Gender.noBinarioOOtro.description).tag(Gender.noBinarioOOtro.rawValue)
                        }
                        .pickerStyle(.menu)
                        .labelsHidden()
                        
                    }
//                    .padding()
                    .padding(.horizontal)
                    
                    
                    

                    // Botón de registro (simulando CustomButton)
                    CustomButton(hint: "Registrar", action: {
                        authViewModel.register(name: name, email: email, username: username, password: password, phone: phone, country: country?.name, birthdate: birthdate, genderIdentity: genderIdentity, genderPreference: genderPreference)
                    }).padding(.top, 30)
                    
                    
                    HStack {
                        Text("¿Ya tienes una cuenta?")
                            .foregroundStyle(Color.secondary)
                        Button(action: {
                            dismiss()
                        }) {
                            Text("Inicia Sesión")
//                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.top, 10)
                    
                }
            }
            .onAppear(){
                authViewModel.getCountries()
            }
//            .navigationTitle("Registro")
        }
//    }
}

#Preview {
    RegisterView()
}
