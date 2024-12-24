//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by MacBook Air on 9.12.24.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private let authService = AuthService()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()

        self.window = UIWindow(frame: UIScreen.main.bounds)
        Task() {
            if await authService.isLogin() {
                self.setRootViewControllerToMainScreen()
            } else {
                self.setRootViewControllerToAuthScreen()
            }
            self.window?.makeKeyAndVisible()
        }
        return true
    }
}

// MARK: - Выбор контроллера в зависимости от авторизации пользователя -
extension AppDelegate {
    func setRootViewControllerToMainScreen(){
        window?.rootViewController = UINavigationController(rootViewController: TabBarViewController())
    }
    
    func setRootViewControllerToAuthScreen(){
        window?.rootViewController = UINavigationController(rootViewController: AuthorizationViewController())
    }
}
