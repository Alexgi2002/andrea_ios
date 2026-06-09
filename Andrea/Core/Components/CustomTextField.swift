//
//  CustomTextField.swift
//  Andrea
//
//  Created by AlexGI on 05/06/2026.
//

import SwiftUI

struct CustomTextField: View {
    
    @Binding var text: String
    var hint: String
    var leadingText: String?
    var icon: String
    var keyboardType: UIKeyboardType
    
    var body: some View {
        Label(
            title: {
                HStack {
                    if let x = leadingText {
                        Text(x)
                    }
                    
                    TextField(hint, text: $text)
                        .keyboardType(keyboardType)
                }
                    
            },
            icon: {
                Image(systemName: icon)
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
    CustomTextField(text: $text, hint: "Escribe tu mensaje", leadingText: "+53", icon: "person", keyboardType: .default)
}
