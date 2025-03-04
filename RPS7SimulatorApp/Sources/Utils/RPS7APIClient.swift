//
//  RPS7APIClient.swift
//  RPS7SimulatorApp
//
//  Created by Sora Oya on 2025/03/04.
//

import API
import Foundation

struct RPS7APIClient: APIClient {
    init(
        session: URLSessionProtocol = URLSession.shared
    ) {
        self.session = session
    }

    var baseURL: String {
        "http://52.195.82.85:5000/"
    }

    let session: URLSessionProtocol
    private let decoder = JSONDecoder()

    func data(path: String? = nil) async throws -> Data {
        let request = urlRequest(path: path)
        return try await data(request)
    }

    func response<Response: Decodable>(path: String?) async throws -> Response {
        do {
            let data = try await data(path: path)
            return try decode(data)
        } catch {
            throw error
        }
    }

    private func decode<Response: Decodable>(_ data: Data) throws -> Response {
        do {
            let decoded = try decoder.decode(Response.self, from: data)
            return decoded
        } catch {
            throw APIError.unknown(error)
        }
    }
}

extension APIClient where Self == RPS7APIClient {
    static var `default`: APIClient {
        RPS7APIClient()
    }
}
