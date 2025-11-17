//
//  ContentView.swift
//  SpeechJammer
//
//  Created by Alejandra Gallo Cortés on 13/11/25.
//

import SwiftUI
import TipKit

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var audio = SpeechJammerAudio()
    @State private var isOn = false
    @State private var delay = 0.25
    @State private var currentTongueTwister = "How much wood would a woodchuck chuck if a woodchuck would chuck wood?"
    let lightOrange = Color(red: 255/255, green: 243/255, blue: 231/255)
    let darkOrange = Color(red: 127/255, green: 68/255, blue: 8/255)
    
    @State private var breathe = false
    @State private var isMouthOpen = false
    @State private var animationTimer: Timer?
    
    var body: some View {
        VStack {
            HStack {
                Text("Speech Jammer")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.bottom, 45)
            .padding(.horizontal)
            .padding(.top)
            HStack(alignment: .top) {
                Text(currentTongueTwister)
                    .font(.system(size: 36))
                    .fontWeight(.bold)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(4)
                    .minimumScaleFactor(0.7)
                Spacer()
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, minHeight: 150, maxHeight: 150, alignment: .top)
            Spacer()
            VStack {
                Button {
                    isOn.toggle()
                    
                } label: {
                    Image(systemName: "microphone.circle.fill")
                        .font(.system(size: 118))
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(isOn ? lightOrange : .orange, isOn ? .orange : (colorScheme == .dark ? darkOrange : lightOrange))
                        .scaleEffect(isOn && breathe ? 1.1 : 1.0)
                        .onChange(of: isOn) { oldValue, newValue in
                            if newValue {
                                withAnimation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true)) {
                                    breathe = true
                                }
                            } else {
                                breathe = false
                            }
                        }
                        .popoverTip(TipManager().useHeadphones, arrowEdge: .top)
                }
                .onChange(of: isOn) { oldValue, newValue in
                    if newValue {
                        audio.delayTime = delay
                        audio.start()
                        startMouthAnimation()
                    }else {
                        audio.stop()
                        stopMouthAnimation()
                    }
                }
            }
            .frame(height: 200)
//            VStack {
//                Text("Delay: \(delay, specifier: "%.2f") s")
//                Slider(value: $delay, in: 0.05...0.5, step: 0.01) { editing in
//                    // Update delay live while running
//                    if !editing && isOn {
//                        audio.delayTime = delay
//                    } else if isOn {
//                        audio.delayTime = delay
//                    }
//                }
//            }
//            .padding(.horizontal)
            Spacer()
            ZStack(alignment: .bottom) {
                Image(isOn && isMouthOpen ? "boca_abierta" : "boca_cerrada")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                Button {
                    newTongueTwister()
                } label: {
                    Text("New tongue twister")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    
                        .padding(.bottom, 47)
                }
                
            }
            .frame(maxWidth: .infinity)
            
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .onDisappear {
            audio.stop()
            isOn = false
            stopMouthAnimation()
        }
        .onAppear {
            newTongueTwister()
        }
    }
    
    func newTongueTwister() {
        let amount = tongueTwisters.count
        let randomNumber = Int.random(in: 0..<amount)
        currentTongueTwister = tongueTwisters[randomNumber]
    }
    private func startMouthAnimation(){
        stopMouthAnimation()
        isMouthOpen = false
        
        animationTimer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { _ in
            isMouthOpen.toggle()
        }
    }
    
    private func stopMouthAnimation(){
        animationTimer?.invalidate()
        animationTimer = nil
        isMouthOpen = false
    }
}

#Preview {
    ContentView()
}
