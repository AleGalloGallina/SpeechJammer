//
//  SpeechJammerApp.swift
//  SpeechJammer
//
//  Created by Alejandra Gallo Cortés on 13/11/25.
//

import SwiftUI
import TipKit

@main
struct SpeechJammerApp: App {
    init() {
        try? Tips.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
