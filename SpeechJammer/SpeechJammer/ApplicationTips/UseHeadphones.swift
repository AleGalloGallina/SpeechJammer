//
//  UseHeadphones.swift
//  SpeechJammer
//
//  Created by Alejandra Gallo Cortés on 17/11/25.
//

import Foundation
import TipKit
import SwiftUI

struct UseHeadphones: Tip {
    var title: Text {
        Text("Use headphones")
        
    }
    
    var message: Text? {
        Text("Connect your headphones and click here to start the jammer")
    }
    
    var image: Image? {
        Image(systemName: "headphones")
    }
}

