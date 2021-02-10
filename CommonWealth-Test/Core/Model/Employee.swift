//
//  Employee.swift
//  CommonWealth-Test
//
//  Created by Angga Setiawan on 10/02/21.
//

import Foundation

public struct Employee {
    public let id: Int
    public let name: String
    public let salary: Int
    public let age: Int

    private enum CodingKeys: String, CodingKey {
        case id
        case name = "employee_name"
        case salary = "employee_salary"
        case age = "employee_age"
    }
}

extension Employee: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        salary = try container.decodeIfPresent(Int.self, forKey: .salary) ?? 0
        age = try container.decodeIfPresent(Int.self, forKey: .age) ?? 0
    }
}
