//
//  TestLogicController.swift
//  CommonWealth-Test
//
//  Created by Angga Setiawan on 10/02/21.
//

import UIKit

class TestLogicController: UIViewController {

    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Test Logic"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    fileprivate lazy var inputBox: TextfieldBoxView = {
        let view = TextfieldBoxView()
        view.keyboardType = .numberPad
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

    fileprivate lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "Test Logic"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .right
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(netHex: 0xf4f4fd)
        self.addView()
    }

    @objc fileprivate func submitTapped() {
        let input: Int = Int(self.inputBox.input) ?? 0
        self.resultLabel.text = test(input: input)
    }

    func test(input: Int) -> String {
        if input == 0 {
            print("")
            return ""
        }
        var s: String = ""
        for i in (0..<input).reversed() {
            for j in 0..<input {
                var t: String = ""
                if j >= i && j < input {
                    t.append("#")
                } else {
                    t.append(" ")
                }
                s.append(t)
            }
            s.append("\r\n")
        }
        return "\r\n\(s)"
    }
}

extension TestLogicController {
    fileprivate func addView() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(inputBox)
        self.view.addSubview(submitView)
        self.view.addSubview(resultLabel)

        submitView.addSubview(submitButton)

        titleLabel.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview().inset(16)
        }

        inputBox.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(32)
        }

        submitView.snp.makeConstraints { (make) in
            make.top.equalTo(inputBox.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(32)
        }

        submitButton.snp.makeConstraints { (make) in
            make.edges.equalTo(submitView).inset(8)
        }

        resultLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}
