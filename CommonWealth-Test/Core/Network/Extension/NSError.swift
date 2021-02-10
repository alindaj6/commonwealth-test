//
//  NSError.swift
//  CommonWealth-Test
//
//  Created by Angga Setiawan on 10/02/21.
//

import Foundation

public extension String {

    static let errorSystemDomain = "com.teanco.shushu.error.system"
    static let errorAuthDomain = "com.teanco.shushu.error.auth"
    static let errorServiceDomain = "com.teanco.shushu.error.service"
    static let errorLogicDomain = "com.teanco.shushu.error.logic"
}

public extension NSError {

    var isUnauthenticated: Bool {
        return self.code == 401
    }
}
