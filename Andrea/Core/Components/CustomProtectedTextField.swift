//
//  CustomTextField.swift
//  Andrea
//
//  Created by AlexGI on 05/06/2026.
//

import SwiftUI

struct CustomProtectedTextField: View {
    
    @Binding var text: String
    var hint: String
    
    @State private var showPassword = false
    
    var body: some View {
        Label(
            title: {
                ZStack(alignment: .trailing) {
                    if showPassword {
                        TextField(hint, text: $text)
                            .padding(.trailing, 40)
                    } else {
                        SecureField(hint, text: $text)
                            .padding(.trailing, 40)
                    }
                    Button(action: {
                        showPassword.toggle()
                    }) {
                        Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 10)
                }
                
                    
            },
            icon: {
                Image(systemName: "lock")
                    .padding(.trailing, 8)
            }
        )
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
        .padding()
        
    }
}

#Preview {
    @Previewable @State var text: String = ""
    CustomProtectedTextField(text: $text, hint: "Escribe tu mensaje")
}
