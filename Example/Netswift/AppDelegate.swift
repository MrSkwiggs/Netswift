//
//  AppDelegate.swift
//  Netswift
//
//  Created by MrSkwiggs on 05/11/2019.
//  Copyright (c) 2019 MrSkwiggs. All rights reserved.
//

import UIKit
import Netswift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        NetswiftPerformer().perform(MyAPI.helloWorld) { result in
            guard let response = result.value else {
                if let error = result.error {
                    print(error)
                }
                return
            }
            
            // Our request succeeded: we now have an object of type MyAPI.Response available to use
            print(response.title)
        }
        
        return true
    }
}

