//
//  RPS7.swift
//  RPS7SimulatorApp
//
//  Created by Sora Oya on 2025/03/04.
//

import Foundation

struct RPS7: Hashable {
    var hand: Hand
}

extension RPS7 {
    enum Hand: Hashable {
        case rock
        case scissors
        case paper
        case water
        case air
        case sponge
        case fire
    }
}
