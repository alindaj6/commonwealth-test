//
//  EmployeeUpdateView.swift
//  CommonWealth-Test
//
//  Created by Angga Setiawan on 10/02/21.
//

import UIKit

protocol EmployeeUpdateDelegate: class {
    func submitTapped(_ employee: Employee)
    func closeTapped()
}

class EmployeeUpdateView: UIView {

    var employee: Employee! {
        didSet {
            self.nameBox.input = employee.name
            self.salaryBox.input = "\(employee.salary)"
            self.ageBox.input = "\(employee.age)"
        }
    }

    fileprivate lazy var containerBoxView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.yellow.withAlphaComponent(0.5)
        view.layer.cornerRadius = 10
        return view
    }()

    fileprivate lazy var nameBox: TextfieldBoxView = {
        let view = TextfieldBoxView()
        view.type = .name
        return view
    }()

    fileprivate lazy var salaryBox: TextfieldBoxView = {
        let view = TextfieldBoxView()
        view.type = .salary
        return view
    }()

    fileprivate lazy var ageBox: TextfieldBoxView = {
        let view = TextfieldBoxView()
        view.type = .age
        return view
    }()

    fileprivate lazy var submitView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 8
        return view
    }()

    fileprivate lazy var submitButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Submit", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        return btn
    }()

    fileprivate lazy var closeView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 8
        return view
    }()

    fileprivate lazy var closeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Close", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        return btn
    }()

    weak var delegate: EmployeeUpdateDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc fileprivate func submitTapped() {
        delegate?.submitTapped(self.employee)
    }

    @objc fileprivate func closeTapped() {
        delegate?.closeTapped()
    }
}

extension EmployeeUpdateView {
    fileprivate func addView() {
        self.addSubview(containerBoxView)

        [nameBox, salaryBox, ageBox, submitView, closeView].forEach {
            containerBoxView.addSubview($0)
        }

        submitView.addSubview(submitButton)
        closeView.addSubview(closeButton)

        containerBoxView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }

        nameBox.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(containerBoxView).inset(16)
        }

        salaryBox.snp.makeConstraints { (make) in
            make.top.equalTo(nameBox.snp.bottom).offset(16)
            make.leading.trailing.equalTo(nameBox)
        }

        ageBox.snp.makeConstraints { (make) in
            make.top.equalTo(salaryBox.snp.bottom).offset(16)
            make.leading.trailing.equalTo(nameBox)
        }

        submitView.snp.makeConstraints { (make) in
            make.top.equalTo(ageBox.snp.bottom).offset(32)
            make.leading.trailing.equalTo(containerBoxView).inset(32)
            make.centerX.equalTo(containerBoxView)
        }

        submitButton.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(submitView).inset(8)
            make.leading.trailing.equalTo(submitView).inset(12)
        }

        closeView.snp.makeConstraints { (make) in
            make.top.equalTo(submitView.snp.bottom).offset(8)
            make.leading.trailing.equalTo(containerBoxView).inset(32)
            make.centerX.equalTo(containerBoxView)
            make.bottom.equalTo(containerBoxView).inset(16)
        }

        closeButton.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(closeView).inset(8)
            make.leading.trailing.equalTo(closeView).inset(12)
        }
    }
}
