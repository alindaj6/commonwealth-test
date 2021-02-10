//
//  EmployeeInfoView.swift
//  CommonWealth-Test
//
//  Created by Angga Setiawan on 10/02/21.
//

import UIKit

protocol EmployeeInfoDelegate: class {
    func didEditTapped(_ employee: Employee)
    func didDeleteTapped(_ employee: Employee)
}

class EmployeeInfoView: UIView {

    var employee: Employee! {
        didSet {
            self.idLabel.text = "ID: \(employee.id)"
            self.nameLabel.text = "Name: \(employee.name)"
            self.salaryLabel.text = "Salary: \(employee.salary)"
            self.ageLabel.text = "Age: \(employee.age)"
        }
    }

    fileprivate lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()

    fileprivate lazy var idLabel: UILabel = {
        let label = UILabel()
        label.text = "ID: xxxx"
        label.textColor = .black
        return label
    }()

    fileprivate lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name: xxxx"
        label.textColor = .black
        return label
    }()

    fileprivate lazy var salaryLabel: UILabel = {
        let label = UILabel()
        label.text = "Salary: xxxx"
        label.textColor = .black
        return label
    }()

    fileprivate lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.text = "Age: xxxx"
        label.textColor = .black
        return label
    }()

    fileprivate lazy var editView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 8
        return view
    }()

    fileprivate lazy var editButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Edit", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
        return btn
    }()

    fileprivate lazy var deleteView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 8
        return view
    }()

    fileprivate lazy var deleteButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Delete", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        return btn
    }()

    weak var delegate: EmployeeInfoDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc fileprivate func editTapped() {
        delegate?.didEditTapped(self.employee)
    }

    @objc fileprivate func deleteTapped() {
        delegate?.didDeleteTapped(self.employee)
    }
}

extension EmployeeInfoView {
    fileprivate func addView() {
        self.addSubview(containerView)
        [idLabel, nameLabel, salaryLabel,
         ageLabel, editView, deleteView]
            .forEach { containerView.addSubview($0)
        }

        editView.addSubview(editButton)
        deleteView.addSubview(deleteButton)

        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        idLabel.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(containerView).inset(8)
        }

        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(idLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(idLabel)
        }

        salaryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(idLabel)
        }

        ageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(salaryLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(idLabel)
        }

        editView.snp.makeConstraints { (make) in
            make.top.equalTo(ageLabel.snp.bottom).offset(32)
            make.leading.trailing.equalTo(idLabel)
        }

        editButton.snp.makeConstraints { (make) in
            make.edges.equalTo(editView).inset(8)
        }

        deleteView.snp.makeConstraints { (make) in
            make.top.equalTo(editView.snp.bottom).offset(8)
            make.leading.trailing.equalTo(idLabel)
            make.bottom.equalTo(containerView).inset(16)
        }

        deleteButton.snp.makeConstraints { (make) in
            make.edges.equalTo(deleteView).inset(8)
        }
    }
}
