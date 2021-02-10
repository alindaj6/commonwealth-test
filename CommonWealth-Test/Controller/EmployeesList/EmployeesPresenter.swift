//
//  EmployeesPresenter.swift
//  CommonWealth-Test
//
//  Created by Angga Setiawan on 10/02/21.
//

import Foundation

protocol EmployeesBaseView: BaseView {
    func loadUI()
    func loading(isShow: Bool)
    func loadData(_ employees: [Employee])
    func deleteSuccess()
    func updateSuccess()
}

protocol EmployeesPresenter: BasePresenter {
    func load()
    func loadData()
    func delete(_ employee: Employee)
    func update(_ employee: Employee, employeeReqParam: EmployeeReqParam)
}

class EmployeesPresenterImpl: EmployeesPresenter {

    weak var view: EmployeesBaseView?

    let providerEmployee = ServiceHelper.provider(for: EmployeeAPI.self)

    init(view: EmployeesBaseView) {
        self.view = view
    }

    func load() {
        self.view?.loadUI()
        self.loadData()
    }

    func loadData() {
        self.view?.loading(isShow: true)
        providerEmployee.request(.list) { (result) in
            switch result.map(to: [Employee].self) {
            case .success(let response):
                if let employees = response.data {
                    self.view?.loadData(employees)
                }
            case .failure(let error):
                print("error --> \(error.localizedDescription)")
            }
            self.view?.loading(isShow: false)
        }
    }

    func delete(_ employee: Employee) {
        self.view?.loading(isShow: true)
        providerEmployee.request(.delete(employeeId: "\(employee.id)")) { (result) in
            switch result.map(to: Dummy.self) {
            case .success: self.view?.deleteSuccess()
            case .failure(let error):
                print("error --> \(error.localizedDescription)")
            }
            self.view?.loading(isShow: false)
        }
    }

    func update(_ employee: Employee, employeeReqParam: EmployeeReqParam) {
        self.view?.loading(isShow: true)
        providerEmployee.request(.update(employeeId: employee.id, param: employeeReqParam)) { (result) in
            switch result.map(to: Dummy.self) {
            case .success: self.view?.updateSuccess()
            case .failure(let error):
                print("error --> \(error.localizedDescription)")
            }
            self.view?.loading(isShow: false)
        }
    }
}
