//
//  APIClient.swift
//  RPS7SimulatorApp
//
//  Created by Sora Oya on 2025/03/04.
//

import Foundation

public protocol APIClient {
    var baseURL: String { get }
    var session: URLSessionProtocol { get }
    func response<Response: Decodable>(path: String?) async throws -> Response
}

public typealias Parameters = any Encodable

extension APIClient {
    public func urlRequest(path: String? = nil) -> URLRequest {
        var url = URL(string: baseURL)!
        if let path {
            url = url.appendingPathComponent(path)
        }
            url = URL(string: url.absoluteString)!

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }

    public func data(path: String? = nil) async throws -> Data {
        let request = urlRequest(path: path)
        return try await data(request)
    }

    public func data(_ request: URLRequest) async throws -> Data {
        do {
            let (data, response) = try await session.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    return data
                default:
                    throw APIError.data(data, httpResponse.statusCode)
                }
            } else {
                throw APIError.invalidResponse
            }
        } catch {
            switch error {
            case URLError.cancelled:
                throw APIError.cancelled
            default:
                throw error as? APIError ?? APIError.unknown(error)
            }
        }
    }
}
