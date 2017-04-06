//
//  AppDelegate.swift
//  SampleApp
//
//  Created by Nabiilah Fasih on 4/5/17.
//  Copyright © 2017 PointClickCare. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        //DEMO - Dynamic actions
//        QuickActionHandler.setDynamicShortcutItems(for: application)
//        return true
        
        //DEMO - Handle actions 1
//        window?.makeKeyAndVisible()
//        
//        var performAdditionalHandling = true
//        
//        if let shortcutItem = launchOptions?[.shortcutItem] as? UIApplicationShortcutItem, let rootViewController = window?.rootViewController
//        {
//            let didHandleShortcutItem = QuickActionHandler.handle(shortcutItem, with: rootViewController)
//            performAdditionalHandling = !didHandleShortcutItem
//        }
//        
//        QuickActionHandler.setDynamicShortcutItems(for: application)
//        
//        return performAdditionalHandling
        
        return true
    }
    
    //DEMO - Handle actions 2
//    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void)
//    {
//        var didHandleShortcutItem = false
//        
//        if let rootViewController = window?.rootViewController
//        {
//            didHandleShortcutItem = QuickActionHandler.handle(shortcutItem, with: rootViewController)
//        }
//        
//        completionHandler(didHandleShortcutItem)
//    }
    
}

