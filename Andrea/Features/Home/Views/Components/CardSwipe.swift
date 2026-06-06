//
//  CardSwipe.swift
//  Andrea
//
//  Created by AlexGI on 06/06/2026.
//

import SwiftUI

enum SwipeAction {
    case like
    case nope
}

struct CardSwipe: View {
    // 1. Estados para controlar el movimiento y la rotación de la tarjeta
    @State private var offset: CGSize = .zero
    
    // Configuración del tamaño estándar de la tarjeta
    private let cardWidth: CGFloat = 380
    private let cardHeight: CGFloat = 550
    
    public var data: UserDTO?
    public var onSwipe: (SwipeAction, Int) -> Void
    
    var body: some View {
        ZStack(alignment: .bottom) { // Alinea los textos abajo del contenedor
            
            // 2. ARREGLO DE LA IMAGEN: Evita la distorsión
            AsyncImage(url: URL(string: data?.images.first?.path ?? "")) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill() // Llena el espacio sin deformar
                        .frame(width: cardWidth, height: cardHeight)
                        .clipped() // Recorta lo que sobresalga
                default:
                    // Color de carga temporal mientras baja la foto
                    Color.darkCardBackground
                        .frame(width: cardWidth, height: cardHeight)
                }
            }
            
            // 3. CAPA DE GRADIENTE: Para que las letras blancas se lean perfectamente sobre fotos claras
            LinearGradient(
                colors: [.clear, .black.opacity(0.8)],
                startPoint: .center,
                endPoint: .bottom
            )
            
            // 4. INDICADORES VISUALES (Cruz y Corazón)
            // Aparecen dinámicamente según la dirección del arrastre (offset.width)
            overlayIndicators
            
            // 5. TEXTOS INFORMATIVOS
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                Text(data?.name ?? "NOMBRE")
                    .font(.title)
                    .bold()
                Text("\(data?.age ?? 25)")
                    .font(.title2)
                Spacer()
            }
            .foregroundColor(.white)
            .padding(24)
        }
        .frame(width: cardWidth, height: cardHeight)
        .background(Color.darkCardBackground)
        .cornerRadius(24)
        .shadow(radius: 8, x: 0, y: 4) // Le da volumen real de "tarjeta"
        .offset(offset)
        .rotationEffect(.degrees(Double(offset.width / 15))) // Rota un poco al llevarla a los lados
        
        // 7. EL GESTO NATIVO DE ARRASTRE
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    // Sigue el movimiento del dedo del usuario
                    withAnimation(.interactiveSpring()) {
                        offset = gesture.translation
                    }
                }
                .onEnded { gesture in
                    // Decide si se descarta o si regresa al centro
                    evaluarDestinoDeTarjeta(width: gesture.translation.width)
                }
        )
        .preferredColorScheme(.dark) // Forzamos el modo oscuro que definimos antes
    }
    
    // --- COMPONENTES SECUNDARIOS ---
    
    // Cálculo de los íconos de Like/Nope
    private var overlayIndicators: some View {
        ZStack {
            // Ícono de Corazón (Aparece al arrastrar a la derecha)
            Image(systemName: "heart.fill")
                .font(.system(size: 80))
                .foregroundColor(Color.appPrimary)
                .opacity(Double(offset.width / 100)) // Se hace más sólido entre más a la derecha vaya
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .padding(30)
            
            // Ícono de Cruz (Aparece al arrastrar a la izquierda)
            Image(systemName: "xmark.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.red)
                .opacity(Double(-offset.width / 100)) // Se activa con valores negativos de X
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .padding(30)
        }
    }
    
    // Lógica para lanzar la tarjeta fuera de la pantalla o devolverla
    private func evaluarDestinoDeTarjeta(width: CGFloat) {
        let limiteDeCorte: CGFloat = 150
        
        withAnimation(.spring()) {
            if width > limiteDeCorte {
                // Swipe Derecho (Like): Lanza la tarjeta fuera de la pantalla por la derecha
                offset = CGSize(width: 500, height: offset.height)
                onSwipe(.like, data?.id ?? -1)
//                print("Llamar UseCase de Guardar Like de Go...")
            } else if width < -limiteDeCorte {
                // Swipe Izquierdo (Nope): Lanza la tarjeta por la izquierda
                offset = CGSize(width: -500, height: offset.height)
//                print("Ignorar candidato...")
                onSwipe(.nope, data?.id ?? -1)
            } else {
                // No arrastró lo suficiente: Regresa magnéticamente al centro
                offset = .zero
            }
        }
    }
}

#Preview {
    CardSwipe(data: nil, onSwipe: {s,i in})
}
