//
//  ProfileViewController.swift
//  SeSAC7Recap2
//
//  Created by Jack on 8/30/25.
//

import UIKit
import Alamofire
import SnapKit
import Kingfisher

struct Profile: Decodable {
    let user_id: String
    let nick: String
    let email: String
    let profileImage: String?
}

struct ProfileEdit: Decodable {
    let user_id: String
    let nick: String
    let email: String
    let profileImage: String?
}
 
class ProfileViewController: UIViewController {

    let nickTextField = SignTextField(placeholderText: "닉네임")
    let editButton = PointButton(title: "프로필 수정")
    let logoutButton = PointButton(title: "로그아웃")
    let profileImage = UIImageView()
      
    override func viewDidLoad() {
        super.viewDidLoad()
  
        configureLayout()
        logoutButton.addTarget(self, action: #selector(logoutButtonClicked), for: .touchUpInside)
        editButton.addTarget(self, action: #selector(editButtonClicked), for: .touchUpInside)
        
        getProfile()
    }
    
    func getProfile() {
        let url = APIKey.baseURL + "v1/users/me/profile"
        let headers: HTTPHeaders = [
            "SesacKey": APIKey.sesacKey,
            "Authorization": UserDefaults.standard.string(forKey: "token")!
        ]
        AF.request(url, method: .get, headers: headers)
            .responseDecodable(of: Profile.self) { response in
                switch response.result {
                case .success(let value):
                    print(value)
                    self.navigationItem.title = value.email
                    self.nickTextField.text = value.nick
                    
                case .failure(let error):
                    print(error)
                    
                }
            }
    }
    
    @objc func editButtonClicked() {
        print(#function)
        
        let url = APIKey.baseURL + "v1/users/me/profile"
        let headers: HTTPHeaders = [
            "SesacKey": APIKey.sesacKey,
            "Authorization": UserDefaults.standard.string(forKey: "token")!,
            "Content-Type": "application/json"
        ]
        let parameters = [
            "nick": nickTextField.text!
        ]
        AF.request(url, method: .put, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers)
            .responseDecodable(of: ProfileEdit.self) { response in
                switch response.result {
                case .success(let value):
                    print(value)
                    self.getProfile()
                    
                case .failure(let error):
                    print(error)
                    
                }
            }
    }
    
    @objc func logoutButtonClicked() {
        print(#function)
        
        UserDefaults.standard.removeObject(forKey: "token")
        
        if UserDefaults.standard.string(forKey: "token") == nil {
            //첫 화면 분기처리, window RootViewController 전환
        } else {
            // 아직 화면을 넘기면 안되는 상황
        }
    }
    
    func configureLayout() {
        view.backgroundColor = .white
        view.addSubview(nickTextField)
        view.addSubview(editButton)
        view.addSubview(logoutButton)
        view.addSubview(profileImage)
        
        nickTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
         
        editButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(nickTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(editButton.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        profileImage.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.centerX.equalTo(view)
            make.top.equalTo(logoutButton.snp.bottom).offset(20)
        }
         
    }
}
