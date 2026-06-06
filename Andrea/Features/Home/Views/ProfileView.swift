//  ProfileView.swift
//  Andrea
//
//  Created by AlexGI on 06/06/2026.
//

import SwiftUI

struct Options: Identifiable {
    var id: String
    var title: String
    var icon: String
}

struct ProfileView: View {
    @Environment(HomeViewModel.self) private var viewModel
    
    @State var showDialogLogout : Bool = false
    
    private var options: [Options] {
        [
            Options(id: "1", title: "Editar perfil", icon: "person"),
            Options(id: "2", title: "Cambiar contraseña", icon: "lock"),
            Options(id: "3", title: "Ajustes", icon: "gear"),
            Options(id: "4", title: "Usuarios bloqueados", icon: "xmark.circle"),
            Options(id: "5", title: "Me gusta", icon: "heart.fill"),
//            Options(id: "6", title: "Cerrar sesion"),
        ]
    }
    
    var body: some View {
        if let user = viewModel.me {
            ScrollView{
                VStack{
                    AsyncImage(url: URL(string: user.images.first?.path ?? "")) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
//                                .clipped()
                        default:
                            Color.darkCardBackground
                                .frame(width: 100, height: 100)
                        }
                    }.cornerRadius(50)
                    
                    Text(user.name)
                        .font(.title)
                    Text("@\(user.username)")
                        .font(.caption)
                    
                    VStack{
                        ForEach(options){ p in
                            NavigationLink(value: ""){
                                HStack {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 16)
                                            .tint(.gray.opacity(0.6))
                                        Image(systemName: p.icon, )
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: 45, maxHeight: 45)
                                            .tint(.appPrimary)
                                            .padding()
                                        
                                    }.frame(maxWidth: 50, maxHeight: 50)
                                    Text(p.title)
                                        .font(.headline)
                                        Spacer()
                                    Image(systemName: "chevron.right")
                                    }
                            }.padding(.bottom, 10)
                        }
                        
                    }
                    .padding()
                    .background(Color.darkCardBackground)
                    .cornerRadius(16)
                    .padding()
                    
                    Button("Cerrar sesion", action: {
                        showDialogLogout = true
                        
                    })
                    .tint(.red)
                    .confirmationDialog("Desea cerrar sesion?",isPresented: $showDialogLogout){
                        Button("Aceptar", role: .destructive){
                            showDialogLogout = false
                            AuthManager.shared.logout()
                        }
                    }
                }
            }
        }
        else{
            ProgressView()
        }
        
    }
}

#Preview {
    ProfileView()
}
