//
//  AppDelegate.swift
//  FitnessApp
//
//  Created by Trek on 10/18/22.
//

import UIKit
import Parse
import GooglePlaces

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSPlacesClient.provideAPIKey("AIzaSyAD4dYBn4S0piz2hhzULtN88Fgw5bVVNfI")
        let parseConfig = ParseClientConfiguration  {
            
            $0.applicationId = "Cc9DPOw0vSCkk5meGqQgTpMtir0aUyvoqKf8zT7l"
            $0.clientKey = "MKBsCyLziJ8MZBtHMObK4kZry1vS57i5sO8RiUQ8"
            $0.server = "https://parseapi.back4app.com"
        }
        Parse.initialize(with: parseConfig)
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

