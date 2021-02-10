//
//  EmployeeCell.swift
//  CommonWealth-Test
//
//  Created by Angga Setiawan on 10/02/21.
//

import UIKit

extension UITableViewCell {
    static func identifier() -> String {
        return String(describing: self)
    }

    func contentViewUserInteractionDisabled() {
        self.contentView.isUserInteractionEnabled = false
    }
}

class EmployeeCell: UITableViewCell {

    func setupUI(employee: Employee, delegate: EmployeeInfoDelegate?) {
        self.employeeInfoView.employee = employee
        self.employeeInfoView.delegate = delegate
    }

    fileprivate lazy var employeeInfoView: EmployeeInfoView = {
        let view = EmployeeInfoView()
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentViewUserInteractionDisabled()
        setupLayout()
        self.backgroundColor = UIColor.clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

extension EmployeeCell {
    fileprivate func setupLayout() {
        self.addSubview(employeeInfoView)
        employeeInfoView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(8)
        }
    }
}
