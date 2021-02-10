//
//  TextfieldBoxView.swift
//  CommonWealth-Test
//
//  Created by Angga Setiawan on 10/02/21.
//

import UIKit

enum TextfieldBoxType {
    case name
    case salary
    case age

    var placeholder: String {
        switch self {
        case .name: return "Name"
        case .salary: return "Salary"
        case .age: return "Age"
        }
    }
}

class TextfieldBoxView: UIView {

    var input: String! {
        get {
            return self.inputTextfield.text ?? ""
        }
        set {
            self.inputTextfield.text = newValue
        }
    }

    var type: TextfieldBoxType! {
        didSet {
            self.inputTextfield.placeholder = type.placeholder
        }
    }

    var keyboardType: UIKeyboardType! {
        didSet {
            self.inputTextfield.keyboardType = keyboardType
        }
    }

    fileprivate lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        return view
    }()

    fileprivate lazy var inputTextfield: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Input"
        return textfield
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TextfieldBoxView {
    fileprivate func addView() {
        self.addSubview(containerView)
        containerView.addSubview(inputTextfield)

        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        inputTextfield.snp.makeConstraints { (make) in
            make.edges.equalTo(containerView).inset(16)
            make.height.equalTo(30)
        }
    }
}
