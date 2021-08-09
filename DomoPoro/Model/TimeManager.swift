//
//  TimeManager.swift
//  DomoPoro
//
//  Created by Cristian Costa on 03/08/2021.
//

import Foundation
import AVFoundation

struct TimeManager {
    var totalTime: (name: String, seconds: Int) = ("25:00", 25 * 60 - 1)
    var countdownTime: Int = 25 * 60 - 1

    let timeArray: [(name: String, seconds: Int)] = [
        ("10:00", 10 * 60 - 1),
        
        ("20:00", 20 * 60 - 1),
        ("25:00", 25 * 60 - 1),
        ("30:00", 30 * 60 - 1),
        ("40:00", 40 * 60 - 1),
        ("50:00", 50 * 60 - 1),
        ("60:00", 60 * 60 - 1)
    ]
}
