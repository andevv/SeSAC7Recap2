//
//  ViewController.swift
//  SeSAC7Recap2
//
//  Created by Jack on 8/30/25.
//

/* Notification 관련 정책
 - 포그라운드에서 알림이 안뜨는 게 정상. default
 - 포그라운드에서도 알림을 받고 싶다면, delegate 설정으로 별도 구현
 - TimeInterval 기반 반복은 60초 이상부터 가능
 - 뱃지 숫자는 알림 개수랑 무관. 일일이 관리해줘야 함
 - 알림 스택은 identifier 기준으로 쌓임
 - add()는 64개 제한
 - 알림을 보냈다고 해서, 알림이 알림센터에 잘 전달돼서 보이고 있는지, 사용자에게 문제없이 전달되었는지 알 수 없음
 - 단, 사용자가 알림을 '클릭'했을 때는 확인이 가능
 */

import UIKit

enum MyString: String {
    case navTitle = "navigation_title"
}

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
        
        navigationItem.title = MyString.navTitle.rawValue.localized
    }
    
    @objc func timeButtonClicked() {
        
        let content = UNMutableNotificationContent()
        content.title = "고래밥 \(Int.random(in: 1...100))"
        content.subtitle = "서브타이틀입니다"
        content.badge = 1
        content.body = "바디입니다"
        content.userInfo = ["type": 1,
                            "user_id": 1234,
                            "nick": "칙촉"]
        
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 5,
            repeats: false
        )
        
        let request = UNNotificationRequest(
            identifier: "jack test \(Date())",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            print("add", error)
        }
        
    }
    
    @objc func calendarButtonClicked() {
        let content = UNMutableNotificationContent()
        content.title = "고래밥 \(Int.random(in: 1...100))"
        content.subtitle = "서브타이틀입니다22222"
        content.badge = 1
        content.body = "바디입니다222222"
        content.userInfo = ["type": 1,
                            "user_id": 1234,
                            "nick": "칙촉"]
        
        var components = DateComponents()
        components.minute = 55 //매 55분마다
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: "jack test \(Date())",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            print("add", error)
        }
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

