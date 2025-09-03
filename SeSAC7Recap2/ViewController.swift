//
//  ViewController.swift
//  SeSAC7Recap2
//
//  Created by Jack on 8/30/25.
//

import UIKit

class ViewController: UIViewController {
    
    let emailTextField = SignTextField(placeholderText: "로컬알림 타이틀")
    let passwordTextField = SignTextField(placeholderText: "비밀번호를 바디")
    let signInButton = PointButton(title: "Time 기반 로컬 알림 보내기")
    let signUpButton = PointButton(title: "Calendar 기반 로컬 알림 보내기")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        
        signUpButton.addTarget(self, action: #selector(calendarButtonClicked), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(timeButtonClicked), for: .touchUpInside)
    }
    
    @objc func timeButtonClicked() {
        
        let content = UNMutableNotificationContent()
        content.title = "타이틀입니다"
        content.subtitle = "서브타이틀입니다"
        content.badge = 35
        content.body = "바디입니다"
        
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 10,
            repeats: false
        )
        
        let request = UNNotificationRequest(
            identifier: "jack",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            print("add", error)
        }
    }
    
    @objc func calendarButtonClicked() {
        
    }

    func configureLayout() {
        view.backgroundColor = .white
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        signInButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(signInButton.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
    }
}

