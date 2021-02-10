//
//  Result.swift
//  CommonWealth-Test
//
//  Created by Angga Setiawan on 10/02/21.
//

import Foundation
import Moya

public enum ResponseFormatter {

    case v1Object
    case v1Array

    func format<C: Decodable>(to: C.Type, from data: Data, statusCode: Int) -> Result<AppResponse<C>, NSError> {
        do {
            switch self {
            case .v1Object:
                return try formatV1(to: C.self, from: data, statusCode: statusCode)
            case .v1Array:
                return try formatV1(to: C.self, from: data, statusCode: statusCode)
            }
        } catch {
            print("[JSON] Error: \(error) | Type: \(to)")
            return .failure(NSError(
                domain: .errorLogicDomain,
                code: statusCode,
                userInfo: [NSLocalizedDescriptionKey: error.localizedDescription]
            ))
        }
    }

    private func formatV1<C: Decodable>(to: C.Type, from data: Data, statusCode: Int) throws
        -> Result<AppResponse<C>, NSError> {
            let response = try JSONDecoder().decode(AppResponse<C>.self, from: data)
            if statusCode / 100 == 2 {
                return .success(response)
            }

            return .failure(NSError(
                domain: .errorLogicDomain,
                code: statusCode,
                userInfo: [NSLocalizedDescriptionKey: response.status.rawValue]
            ))
    }
}

public extension Result where Success: Moya.Response {

    func map<C: Decodable>(to: C.Type, formatter: ResponseFormatter = .v1Object) -> Result<AppResponse<C>, NSError> {
        switch self {
        case .success(let moyaResponse):
            if moyaResponse.statusCode == 401 {
//                NotificationCenter.default.post(name: .unauthenticated, object: nil)
                return .failure(NSError(
                    domain: .errorAuthDomain,
                    code: moyaResponse.statusCode,
                    userInfo: nil
                ))
            }

            if moyaResponse.statusCode / 100 == 5 {
                return formatter.format(to: C.self, from: moyaResponse.data, statusCode: moyaResponse.statusCode)
            }
            return formatter.format(to: C.self, from: moyaResponse.data, statusCode: moyaResponse.statusCode)
        case .failure(let error):
            return .failure(NSError(
                domain: .errorSystemDomain,
                code: 0,
                userInfo: [NSLocalizedDescriptionKey: error.localizedDescription]
            ))
        }
    }
}
