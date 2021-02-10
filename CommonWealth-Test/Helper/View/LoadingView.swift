//
//  LoadingView.swift
//  CommonWealth-Test
//
//  Created by Angga Setiawan on 10/02/21.
//

import UIKit

class LoadingView: UIView {

    fileprivate lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    fileprivate lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.isHidden = false
        indicator.startAnimating()
        return indicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        self.backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoadingView {
    fileprivate func addView() {
        self.addSubview(containerView)
        containerView.addSubview(activityIndicator)

        containerView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }

        activityIndicator.snp.makeConstraints { (make) in
            make.edges.equalTo(containerView)
            make.size.equalTo(80)
        }
    }
}
