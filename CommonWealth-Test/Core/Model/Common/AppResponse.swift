//
//  AppResponse.swift
//  CommonWealth-Test
//
//  Created by Angga Setiawan on 10/02/21.
//

import Foundation

public struct AppResponse<T: Decodable> {

    public enum ResponseStatus: String, Decodable {

        case success
        case error
    }

    public let status: ResponseStatus
    public let message: String
    public let data: T?

    init(data: T?, message: String) {
        self.status = .success
        self.message = message
        self.data = data
    }

    private enum CodingKeys: String, CodingKey {

        case status
        case message
        case data
    }
}

extension AppResponse: Decodable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(ResponseStatus.self, forKey: .status)
        message = try container.decode(String.self, forKey: .message)
        if T.self != Dummy.self {
            do {
                data = try container.decode(T.self, forKey: .data)
            } catch {
                data = nil
                print("[JSON] Error: \(error) | Type: \(T.self)")
            }
        } else {
            data = nil
        }
    }
}
