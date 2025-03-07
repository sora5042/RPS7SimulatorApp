//
//  RPS7API.swift
//  RPS7SimulatorApp
//
//  Created by Sora Oya on 2025/03/04.
//

import Foundation

public struct RPS7API: APIEndpoint {
    public init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    public let apiClient: APIClient
    public let path = "v1/junken"

    public func get() async throws -> RPS7 {
        try await apiClient.response(path: path)
    }
}
