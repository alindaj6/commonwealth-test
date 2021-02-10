//
//  UINavigationController.swift
//  CommonWealth-Test
//
//  Created by Angga Setiawan on 10/02/21.
//

import UIKit

extension UINavigationController {

    static var topMostVc: UIViewController? {
        var topController: UIViewController?
        if #available(iOS 13.0, *) {
            topController = UIApplication.shared.windows.first?.rootViewController
        } else {
            // Code for earlier iOS versions
            topController = UIApplication.shared.keyWindow?.rootViewController
        }
        while topController?.presentedViewController != nil {
            topController = topController?.presentedViewController
        }
        if let tab = topController as? UITabBarController {
            topController = tab.selectedViewController
        }
        if let navigation = topController as? UINavigationController {
            topController = navigation.visibleViewController
        }
        return topController
    }
}
