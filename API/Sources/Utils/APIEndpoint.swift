//
//  APIEndpoint.swift
//  RPS7SimulatorApp
//
//  Created by Sora Oya on 2025/03/04.
//

import Foundation

public protocol APIEndpoint {
    var apiClient: APIClient { get }
    var path: String { get }
}
