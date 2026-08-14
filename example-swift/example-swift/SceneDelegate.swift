//
//  SceneDelegate.swift
//  example-swift
//
//  Copyright © 2026 PAY, Inc. All rights reserved.
//

import UIKit
import PAYJP

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard scene is UIWindowScene else { return }

        if let urlContext = connectionOptions.urlContexts.first {
            ThreeDSecureProcessHandler.shared.completeThreeDSecureProcess(url: urlContext.url)
        }
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let urlContext = URLContexts.first else { return }
        ThreeDSecureProcessHandler.shared.completeThreeDSecureProcess(url: urlContext.url)
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
