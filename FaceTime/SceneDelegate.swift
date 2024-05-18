//
//  SceneDelegate.swift
//  FaceTime
//
//  Created by Mehmet ALAN on 17.05.2024.
//

import FirebaseAuth
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let rootViewController: UIViewController
        if AuthManager.shared.isSignedIn {
            rootViewController = AccountViewController()
            if let email = Auth.auth().currentUser?.email {
                CallManager.shared.setUp(email: email)
            }
        } else {
            rootViewController = WelceomeViewController()
        }
        window.rootViewController = UINavigationController(rootViewController: rootViewController)
        window.makeKeyAndVisible()
        self.window = window
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
    
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }


}

