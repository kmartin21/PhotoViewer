//
//  AlertMessage.swift
//  PhotoViewer
//
//  Created by keith martin on 8/25/17.
//  Copyright © 2017 Keith Martin. All rights reserved.
//

import Foundation
import Whisper

enum AlertMessageType {
    case success
    case fail
    case none
}

func showAlertMessage(message: String, messageType: AlertMessageType) {
    var murmur: Murmur
    switch messageType {
    case .success:
        murmur = Murmur(title: message, backgroundColor: .successGreen, titleColor: .white, font: .descriptionSmall, action: nil)
    case .fail:
        murmur = Murmur(title: message, backgroundColor: .failRed, titleColor: .white, font: .descriptionSmall, action: nil)
    case .none:
        murmur = Murmur(title: message, backgroundColor: .backgroundGrey, titleColor: .white, font: .descriptionSmall, action: nil)
    }
    
    DispatchQueue.main.async {
        Whisper.show(whistle: murmur, action: .show(2))
    }
}
