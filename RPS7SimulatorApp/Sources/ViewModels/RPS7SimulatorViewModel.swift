//
//  RPS7SimulatorViewModel.swift
//  RPS7SimulatorApp
//
//  Created by Sora Oya on 2025/03/04.
//

import Foundation

@MainActor
final class RPS7SimulatorViewModel: ObservableObject {
    private let rps7Service: RPS7Service

    @Published
    private(set) var computerHand: Hand?

    @Published
    private(set) var playerHand: Hand?

    @Published
    var resultText: String?

    init(
        rps7Service: RPS7Service = .init()
    ) {
        self.rps7Service = rps7Service
    }

    func playRPS7(playerHand: Hand) async {
        self.playerHand = playerHand

        do {
            let rps7 = try await rps7Service.computerHand()
            computerHand = .init(hand: rps7.hand)
            determineWinner(playerHand: playerHand, computerHand: computerHand)
        } catch {
            print(error)
        }
    }

    private func determineWinner(playerHand: Hand, computerHand: Hand?) {
        guard let computerHand = computerHand else { return }
        if playerHand == computerHand {
            resultText = "あいこ！"
            return
        }

        let winningCombinations: [Hand: [Hand]] = [
            .rock: [.fire, .scissors, .sponge],
            .water: [.rock, .fire, .scissors],
            .air: [.water, .rock, .fire],
            .paper: [.air, .water, .rock],
            .sponge: [.paper, .air, .water],
            .scissors: [.sponge, .paper, .air],
            .fire: [.scissors, .sponge, .paper]
        ]

        if winningCombinations[playerHand]?.contains(computerHand) ?? false {
            resultText = "あなたの勝ち！"
        } else {
            resultText = "コンピューターの勝ち！"
        }
    }
}

extension RPS7SimulatorViewModel {
    enum Hand: String, Hashable, CaseIterable {
        case rock = "グー"
        case scissors = "チョキ"
        case paper = "パー"
        case water = "ウォーター"
        case air = "エア"
        case sponge = "スポンジ"
        case fire = "ファイヤー"

        init(hand: RPS7.Hand) {
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
            }
        }
    }
}
