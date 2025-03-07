//
//  RPS7Service.swift
//  RPS7SimulatorApp
//
//  Created by Sora Oya on 2025/03/04.
//

import API
import Foundation

struct RPS7Service {
    var rps7API = RPS7API(apiClient: .default)
    
    func computerHand() async throws -> RPS7 {
        let response = try await rps7API.get()
        return .init(rps7: response)
    }
}

extension RPS7 {
    init(rps7: API.RPS7) {
        self.init(
            hand: .init(hand: rps7.hand)
        )
    }
}

extension RPS7.Hand {
    fileprivate init(hand: API.RPS7.Hand) {
        switch hand {
        case .rock:
            self = .rock
        case .scissors:
            self = .scissors
        case .paper:
            self = .paper
        case .water:
            self = .water
        case .air:
            self = .air
        case .sponge:
            self = .sponge
        case .fire:
            self = .fire
        @unknown default:
            self = .rock
        }
    }
}
