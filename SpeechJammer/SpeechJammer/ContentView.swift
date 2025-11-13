//
//  ContentView.swift
//  SpeechJammer
//
//  Created by Alejandra Gallo Cortés on 13/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var currentTongueTwister = "How much wood would a woodchuck chuck if a woodchuck would chuck wood?"
    let ligthOrange = Color(red: 255/255, green: 243/255, blue: 231/255)
    
    var body: some View {
        VStack {
            HStack {
                Text("Speech Jammer")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.bottom, 45)
            
            HStack {
                Text(currentTongueTwister)
                    .font(.system(size: 36))
                    .fontWeight(.bold)
                Spacer()
            }
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "microphone.circle.fill")
                    .font(.system(size: 118))
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.orange, ligthOrange)
            }
            Spacer()
            ZStack {
                Image("boca_cerrada")
                    .resizable()
                    .scaledToFit()
                Button {
                    newTongueTwister()
                } label: {
                    Text("New tongue twister")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding(.top, 215)
                }
                
            }
            
        }
        .padding()
    }
    
    func newTongueTwister() {
        let amount = tongueTwisters.count
        let randomNumber = Int.random(in: 0..<amount)
        currentTongueTwister = tongueTwisters[randomNumber]
    }
}

#Preview {
    ContentView()
}
