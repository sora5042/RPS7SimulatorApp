//
//  ContentView.swift
//  RPS7SimulatorApp
//
//  Created by Sora Oya on 2025/03/03.
//

import SwiftUI

struct RPS7SimulatorView: View {
    @StateObject
    var viewModel: RPS7SimulatorViewModel = .init()

    var body: some View {
        VStack {
            Spacer()
            if let resultText = viewModel.resultText {
                Result(
                    computerHandText: viewModel.computerHand?.rawValue ?? "",
                    playerHandText: viewModel.playerHand?.rawValue ?? "",
                    resultText: resultText
                ) {
                    viewModel.resultText = nil
                }
            } else {
                Text("勝負に出す手を選択してください")
                    .font(.title)
                Spacer()
                HandButtons { hand in
                    await viewModel.playRPS7(playerHand: hand)
                }
            }
            Spacer()
        }
        .padding()
    }
}

private struct HandButtons: View {
    var selectedHandAction: @MainActor (RPS7SimulatorViewModel.Hand) async -> Void

    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(RPS7SimulatorViewModel.Hand.allCases, id: \.self) { hand in
                Button {
                    Task {
                        await selectedHandAction(hand)
                    }
                } label: {
                    Text(hand.rawValue)
                        .font(.body.bold())
                        .foregroundStyle(.white)
                        .frame(width: 100, height: 50)
                }
                .background(.teal)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }

    private var columns: [GridItem] {
        Array(repeating: .init(.flexible()), count: 3)
    }
}

private struct Result: View {
    var computerHandText: String
    var playerHandText: String
    var resultText: String
    var resetAction: @MainActor () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 20) {
                HStack {
                    Text("コンピューター")
                    Spacer()
                }
                .padding(.bottom)
                Text(computerHandText)
                    Text("VS")
                Text(playerHandText)
                HStack {
                    Spacer()
                    Text("あなた")
                }
                .padding(.top)
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.teal, lineWidth: 10)
            )
            .clipShape(RoundedRectangle(cornerRadius: 20))
            Spacer()
            VStack(spacing: 10) {
                Text("結果は...")
                Text(resultText)
                Button {
                    resetAction()
                } label: {
                    Text("もう一回する")
                        .padding()
                        .foregroundStyle(.white)
                }
                .background(.teal)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            Spacer()
        }
        .padding()
        .font(.title)
    }
}

#Preview {
    RPS7SimulatorView()
}
