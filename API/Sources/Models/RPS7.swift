//
//  RPS7.swift
//  RPS7SimulatorApp
//
//  Created by Sora Oya on 2025/03/04.
//

import Foundation

public struct RPS7: Decodable {
    public var hand: Hand

    public enum Hand: Int, Decodable {
        case rock = 1
        case scissors = 2
        case paper = 3
        case water = 4
        case air = 5
        case sponge = 6
        case fire = 7
    }
}
