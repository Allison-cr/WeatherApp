//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Alexander Suprun on 20.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
         guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let vc = WeatherViewController()
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = vc
        window.makeKeyAndVisible()
        self.window = window
    }
}

