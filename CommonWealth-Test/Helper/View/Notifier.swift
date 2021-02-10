//
//  Notifier.swift
//  CommonWealth-Test
//
//  Created by Angga Setiawan on 10/02/21.
//

import UIKit
import SwiftMessages

class Notifier {

    // MARK: - Alerts

    static func alert(error message: String) {
        Notifier.alert(NSLocalizedString("general.title.error", comment: ""), message: message)
    }

    static func alert(_ title: String, message: String,
                      action: String = NSLocalizedString("general.button.ok", comment: ""),
                      from caller: UIViewController? = UINavigationController.topMostVc,
                      tapHandler: (() -> Void)? = nil) {
        guard let caller = caller else {
            return
        }

        let vc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        vc.addAction(UIAlertAction(
            title: action, style: .default, handler: { (_) in
            tapHandler?()
        }))
        caller.present(vc, animated: true, completion: nil)
    }

    // present popup in a second then dismiss (if second <= 0 then not dismiss)
    static func presentModally(from view: UIView, inSeconds second: TimeInterval = -1.0) {
        let messageView = SwiftMessagesBaseView(frame: .zero)
        messageView.layoutMargins = .zero
        messageView.backgroundHeight = UIScreen.main.bounds.height
        do {
            let backgroundView = CornerRoundingView()
            messageView.installBackgroundView(backgroundView)
            messageView.installContentView(view)
        }
        var config = SwiftMessages.defaultConfig
        if second <= 0 {
            config.duration = .forever
        } else {
            config.duration = .seconds(seconds: second)
        }
        config.presentationStyle = .center
        config.dimMode = .color(color: UIColor(netHex: 0x000000, alpha: 0.7), interactive: false)
        config.interactiveHide = false
        config.preferredStatusBarStyle = .lightContent
        SwiftMessages.show(config: config, view: messageView)
    }

    static func hideModal() {
        SwiftMessages.hide()
    }
}
