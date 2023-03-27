//
//  AppDelegate.swift
//  VC-CyCle
//
//  Created by Allen H on 2022/01/10.
//

import UIKit

// ⭐️ 앱의 라이프사이클의 시점을 파악 할수 있는 함수들이 있음
// 앱의 생명주기의 컨셉 이해하기 (정확하게 말하면 예전 버전 - Scene 도입 전 / iOS 12까지)
/*
 AppDelegate.swift
 (앱의 대리자 역할 / 기존 델리게이트 패턴과 살짝 다른 개념) - 앱이 동작하다 (전화와서) 멈추거나, 그런 시점들을 파악하기 위한 대리자
 
 여기서 다 괸리했음 iOS 까지
 
 SceneDelegate.swift
 (씬의 대리자 역할 / 기존 델리게이트 패턴과 살짝 다른 개념) - 다른 씬으로 넘어가거나, 그런 시점들을 파악하기 위한 대리자 (Foreground / Background) 씬(멀티테스킹의 창)의 개념이 도입되면서 앱 델리게이트의 역할에서 몇가지 개념을 씬델리게이트로 보내버림
 */

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // 앱이 실행되는 시점
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // 활성화 상태를 사임한다. 앱이 잠시 비활성화 되는 시점
        
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

