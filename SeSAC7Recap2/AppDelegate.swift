//
//  AppDelegate.swift
//  SeSAC7Recap2
//
//  Created by Jack on 8/30/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //1.Notification 알림 권한 설정 (필수)
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            print("requestAuthorization:", success, error)
        }
        
        //2. 포그라운드 수신을 위한 Delegate 설정 (옵션)
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    //포그라운드 수신 메서드: willPresent
    //카톡에서 친구랑 1:1 대화의 경우, 당사자 알림은 뜨지 않고, 다른 톡방 알림은 뜸
    //특정 화면, 조건에 대해서 포그라운드 알림을 받도록도 할 수 있음
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print(notification.request.identifier)
        print(notification.request.content.title)
        print(notification.request.content.userInfo)
        
        completionHandler([.sound, .badge, .list, .banner])
    }
    
    //알림을 사용자가 클릭했는지 알 수 있는 메서드
    //클릭 시 특정 VC로 이동시킬 때 사용
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print(response.notification.request.identifier)
        print(response.notification.request.content.title)
        print(response.notification.request.content.userInfo)
        
        let info = response.notification.request.content.userInfo
        
        if let id = info["user_id"] as? Int, let nick = info["nick"] as? String {
            //id를 가진 VC로 이동
            //nick을 VC 아이템 타이틀에 값 전달
            
            
        }
    }
}
