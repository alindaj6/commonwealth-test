//
//  EmployeeReqParam.swift
//  CommonWealth-Test
//
//  Created by Angga Setiawan on 10/02/21.
//

import Foundation

public struct EmployeeReqParam: Exportable {

    let name: String
    let salary: String
    let age: String

    init(name: String, salary: String, age: String) {
        self.name = name
        self.salary = salary
        self.age = age
    }

    public var asDict: [String: Any] {
        var result = [String: Any]()
        result["name"] = self.name
        result["salary"] = self.salary
        result["age"] = self.age
        return result
    }
}
