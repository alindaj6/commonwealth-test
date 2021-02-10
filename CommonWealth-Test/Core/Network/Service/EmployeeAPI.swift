//
//  EmployeeAPI.swift
//  CommonWealth-Test
//
//  Created by Angga Setiawan on 10/02/21.
//

import Foundation
import Moya

public enum EmployeeAPI {
    case create(param: EmployeeReqParam)
    case list
    case update(employeeId: Int, param: EmployeeReqParam)
    case delete(employeeId: String)
}

extension EmployeeAPI: TargetType {

    public var baseURL: URL {
        let serverUrl = "http://dummy.restapiexample.com/api/v1/"
        return URL(string: "\(serverUrl)")!
    }

    public var headers: [String: String]? {
        return nil
    }

    public var path: String {
        switch self {
        case .create:
            return "create"
        case .list:
            return "employees"
        case .update(let employeeId, _):
            return "update/\(employeeId)"
        case .delete(let employeeId):
            return "delete/\(employeeId)"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .create:
            return .post
        case .list:
            return .get
        case .update:
            return .put
        case .delete:
            return .delete
        }
    }

    public var task: Task {
        switch self {
        case .create(let param):
            return .requestParameters(parameters: param.asDict,
                                      encoding: JSONEncoding.default)
        case .list:
            return .requestPlain
        case .update(_, let param):
            return .requestParameters(parameters: param.asDict,
                                      encoding: JSONEncoding.default)
        case .delete:
            return .requestPlain
        }
    }

    public var sampleData: Data {
        return Data()
    }
}
