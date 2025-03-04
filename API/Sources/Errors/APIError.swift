//
//  APIError.swift
//  RPS7SimulatorApp
//
//  Created by Sora Oya on 2025/03/04.
//

import Foundation

public enum APIError: Error {
    case data(Data, Int?)
    case decodeError(Data, Error)
    case message(String)
    case invalidResponse
    case cancelled
    case unknown(Error)
}
