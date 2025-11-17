//
//  SpeechJammerAudio.swift
//  SpeechJammer
//
//  Created by Alejandra Gallo Cortés on 15/11/25.
//

import Foundation
import AVFoundation
import Combine

class SpeechJammerAudio: ObservableObject {
    private let engine = AVAudioEngine()
    private let delay = AVAudioUnitDelay()
    private let session = AVAudioSession.sharedInstance()
    private(set) var isRunning = false
    
    var delayTime: TimeInterval = 0.25 {
        didSet {
            delay.delayTime = max(0.0, min(delayTime, 2.0))
        }
    }
    
    init() {
        setupAudioSession()
        setupEngine()
    }
    
    private func setupAudioSession() {
        do {
            try session.setCategory(.playAndRecord,
                                    mode: .default,
                                    options: [.allowBluetoothHFP, .allowBluetoothA2DP, .mixWithOthers])
            try session.setActive(true)
        } catch {
            print("Audio session error:", error)
        }
    }
    
    private func setupEngine() {
        let input = engine.inputNode
        let format = input.inputFormat(forBus: 0)
        
        delay.delayTime = delayTime
        delay.feedback = 0
        delay.wetDryMix = 100
        
        engine.attach(delay)
        
        engine.connect(input, to: delay, format: format)
        engine.connect(delay, to: engine.mainMixerNode, format: format)
    }
    
    func start() {
        guard !isRunning else { return }
        
        do {
            try engine.start()
            isRunning = true
        } catch {
            print("Could not start engine:", error)
        }
    }
    
    func stop() {
        guard isRunning else { return }
        engine.stop()
        isRunning = false
    }
}
