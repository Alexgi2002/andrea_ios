//
//  CustomButton.swift
//  Andrea
//
//  Created by AlexGI on 05/06/2026.
//

import SwiftUI

struct CustomButton: View {
    
    var hint : String
    var action : ()->()
    
    var body: some View {
        Button(action: action){
            Text(hint)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
        }
//        .frame(minWidth: .infinity)
        .padding(.horizontal, 25)
        .padding(.vertical, 12)
        .background(Color.appPrimary)
        .cornerRadius(16)
        .tint(Color.white)
        .padding(.horizontal, 20)
    }
}

#Preview {
    CustomButton(hint: "Iniciar sesión", action: {})
}
