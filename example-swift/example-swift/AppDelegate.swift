//
//  AppDelegate.swift
//  example-swift
//
//  Created by Tatsuya Kitagawa on 2017/12/08.
//  Copyright © 2017年 PAY, Inc. All rights reserved.
//

import UIKit
import PAYJP

let PAYJPPublicKey = "pk_test_0383a1b8f91e8a6e3ea0e2a9"
let App3DSRedirectURL = "exampleswift://tds/complete"
let App3DSRedirectURLKey = "swift-app"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {

        PAYJPSDK.publicKey = PAYJPPublicKey
        PAYJPSDK.locale = Locale.current
        PAYJPSDK.threeDSecureURLConfiguration =
            ThreeDSecureURLConfiguration(redirectURL: URL(string: App3DSRedirectURL)!,
                                         redirectURLKey: App3DSRedirectURLKey)

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication,
                     didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

}
