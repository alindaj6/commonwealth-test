//
//  EmployeesViewController.swift
//  CommonWealth-Test
//
//  Created by Angga Setiawan on 10/02/21.
//

import UIKit

class EmployeesViewController: UIViewController {

    fileprivate lazy var presenter: EmployeesPresenter = {
        return EmployeesPresenterImpl(view: self)
    }()

    fileprivate lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()

    fileprivate lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "Employee List"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    fileprivate lazy var employeeTableView: UITableView = {
        let tableView = UITableView()
//        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 1000
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = .clear
        tableView.register(EmployeeCell.self,
                                       forCellReuseIdentifier: EmployeeCell.identifier())
        tableView.tableFooterView = UIView(frame: .zero)
        let view = UIView()
        view.backgroundColor = UIColor(netHex: 0xf4f4fd)
        tableView.backgroundView = view
        tableView.reloadData()
        return tableView
    }()

    fileprivate lazy var employees: [Employee] = [] {
        didSet {
            self.employeeTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.presenter.load()
    }
}

extension EmployeesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.employees.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: EmployeeCell.identifier(), for: indexPath)
                as? EmployeeCell else { return UITableViewCell() }
        cell.setupUI(employee: self.employees[indexPath.row],
                     delegate: self)
        return cell
    }
}

extension EmployeesViewController: EmployeeInfoDelegate {
    func didEditTapped(_ employee: Employee) {
        let viewww = EmployeeUpdateView()
        viewww.employee = employee
        viewww.delegate = self
        Notifier.presentModally(from: viewww)
    }

    func didDeleteTapped(_ employee: Employee) {
        self.presenter.delete(employee)
    }
}

extension EmployeesViewController: EmployeeUpdateDelegate {
    func closeTapped() {
        Notifier.hideModal()
    }

    func submitTapped(_ employee: Employee) {
        Notifier.hideModal()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let param = EmployeeReqParam(name: employee.name,
                                         salary: "\(employee.salary)",
                                         age: "\(employee.age)")
            self.presenter.update(employee, employeeReqParam: param)
        }
    }
}

extension EmployeesViewController: EmployeesBaseView {
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

    func loadData(_ employees: [Employee]) {
        self.employees = employees
    }

    func deleteSuccess() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            Notifier.alert("Message", message: "Delete Success", action: "Ok", from: self) {
                self.presenter.loadData()
            }
        }
    }

    func updateSuccess() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            Notifier.alert("Message", message: "Update Success", action: "Ok", from: self) {
                self.presenter.loadData()
            }
        }
    }

    fileprivate func addView() {
        self.view.addSubview(topView)
        self.view.addSubview(employeeTableView)

        topView.addSubview(topLabel)

        topView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
        }

        topLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(topView).inset(8)
        }

        employeeTableView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
