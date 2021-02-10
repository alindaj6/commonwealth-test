//
//  MainViewController.swift
//  CommonWealth-Test
//
//  Created by Angga Setiawan on 10/02/21.
//

import UIKit

class MainViewController: UIViewController {

    fileprivate lazy var presenter: MainScreenPresenter = {
        return MainScreenPresenterImpl(view: self)
    }()

    fileprivate lazy var containerBoxView: UIView = {
        let view = UIView()
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

    fileprivate lazy var showAllView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()

    fileprivate lazy var showAllButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Show All Employees", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(showAllTapped), for: .touchUpInside)
        return btn
    }()

    fileprivate lazy var toTestLogicButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("To Test Logic", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(toTestLogicTapped), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        self.presenter.load()
    }

    @objc fileprivate func showAllTapped() {
//        self.presenter.loadDataEmployees()
        let vc = EmployeesViewController()
        self.present(vc, animated: true, completion: nil)
    }

    @objc fileprivate func submitTapped() {
        let param = EmployeeReqParam(name: self.nameBox.input,
                                     salary: self.salaryBox.input,
                                     age: self.ageBox.input)
        self.presenter.create(param)
    }

    @objc fileprivate func toTestLogicTapped() {
        let vc = TestLogicController()
        self.present(vc, animated: true, completion: nil)
    }
}

extension MainViewController: MainScreenView {
    func loadUI() {
        self.addView()
    }

    func loading(isShow: Bool) {
        if isShow {
            Notifier.presentModally(from: LoadingView())
        } else {
            Notifier.hideModal()
        }
    }

    func submitSuccess() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            Notifier.alert("Message", message: "Create Success",
                           action: "Ok", from: self) { }
        }
    }

    func loadData(_ employees: [Employee]) {
        print("EMP EMP --> \(employees)")
    }

    fileprivate func addView() {
        self.view.addSubview(containerBoxView)
        self.view.addSubview(showAllView)
        self.view.addSubview(toTestLogicButton)

        [nameBox, salaryBox, ageBox, submitView].forEach {
            containerBoxView.addSubview($0)
        }

        showAllView.addSubview(showAllButton)
        submitView.addSubview(submitButton)

        containerBoxView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(32)
        }

        nameBox.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(containerBoxView)
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
            make.bottom.equalTo(containerBoxView)
        }

        submitButton.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(submitView).inset(8)
            make.leading.trailing.equalTo(submitView).inset(12)
        }

        toTestLogicButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(showAllView.snp.top).offset(-8)
        }

        showAllView.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalToSuperview()
        }

        showAllButton.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(showAllView).inset(8)
            make.bottom.equalTo(showAllView).inset(16)
        }
    }
}
