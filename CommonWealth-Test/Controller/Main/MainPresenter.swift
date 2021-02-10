//
//  MainPresenter.swift
//  CommonWealth-Test
//
//  Created by Angga Setiawan on 10/02/21.
//

import Foundation

protocol MainScreenView: BaseView {
    func loadUI()
    func loading(isShow: Bool)
    func submitSuccess()
    func loadData(_ employees: [Employee])
}

protocol MainScreenPresenter: BasePresenter {
    func load()
    func create(_ employeeReqParam: EmployeeReqParam)
    func loadDataEmployees()
}

class MainScreenPresenterImpl: MainScreenPresenter {

    weak var view: MainScreenView?

    let providerEmployee = ServiceHelper.provider(for: EmployeeAPI.self)

    init(view: MainScreenView) {
        self.view = view
    }

    func load() {
        self.view?.loadUI()
    }

    func create(_ employeeReqParam: EmployeeReqParam) {
        self.view?.loading(isShow: true)
        providerEmployee.request(.create(param: employeeReqParam)) { (result) in
            switch result.map(to: Dummy.self) {
            case .success:
                self.view?.submitSuccess()
            case .failure(let error):
                print("error --> \(error.localizedDescription)")
            }
            self.view?.loading(isShow: false)
        }
    }

    func loadDataEmployees() {
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
}
