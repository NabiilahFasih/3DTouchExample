//
//  QuickActionManager.swift
//  SampleApp
//
//  Created by Nabiilah Fasih on 4/5/17.
//  Copyright © 2017 PointClickCare. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

private enum ShortcutIdentifier: String
{
    case newChat
    case sendChatTo
    
    func type() -> String
    {
        return Bundle.main.bundleIdentifier! + "." + self.rawValue
    }
    
    static func getIdentifier(forType type: String) -> ShortcutIdentifier?
    {
        if type == ShortcutIdentifier.newChat.type()
        {
            return ShortcutIdentifier.newChat
        }
        else if type == ShortcutIdentifier.sendChatTo.type()
        {
            return ShortcutIdentifier.sendChatTo
        }
        return nil
    }
}

struct QuickActionHandler
{
    static let userInfoKey = "friendIdentifier"
    
    static func setDynamicShortcutItems(for application: UIApplication)
    {
        requestAccessToContactsIfNeeded(application)
        
        var shortcutItems = [UIApplicationShortcutItem]()
        
        for friend in MockDataManager.shared.topFriends
        {
            let type = ShortcutIdentifier.sendChatTo.type()
            let title = friend.name
            let subtitle = "Send a chat"
            let userInfo = [userInfoKey : friend.identifier]
            
            var icon = UIApplicationShortcutIcon(type: .message)
            if grantedAccessToContacts()
            {
                let predicate = CNContact.predicateForContacts(matchingName: friend.name)
                let contacts = try? CNContactStore().unifiedContacts(matching: predicate, keysToFetch: [])
                if let contact = contacts?.first {
                    icon = UIApplicationShortcutIcon(contact: contact)
                }
            }
            
            let shortcutItem = UIApplicationShortcutItem(type: type, localizedTitle: title, localizedSubtitle: subtitle, icon: icon, userInfo:userInfo)
            
            shortcutItems.append(shortcutItem)
        }
        
        application.shortcutItems = shortcutItems
    }
    
    static func handle(_ shortcutItem: UIApplicationShortcutItem, with rootViewController: UIViewController) -> Bool
    {
        guard let shortcutItemType = ShortcutIdentifier.getIdentifier(forType: shortcutItem.type) else
        {
            return false
        }
        
        var friend: Friend? = nil
        
        if shortcutItemType == .sendChatTo
        {
            if let friendIdentifier = shortcutItem.userInfo?[userInfoKey] as? String
            {
                friend = MockDataManager.shared.friend(for: friendIdentifier)
            }
        }
        
        guard let navigationController = rootViewController as? UINavigationController else { return false }
        navigationController.popToRootViewController(animated: false)
        guard let chatViewController = navigationController.topViewController as? ChatViewController else { return false }
        
        chatViewController.composeNewChat(to: friend)
        
        return true
    }
    
    static private func grantedAccessToContacts() -> Bool
    {
        return CNContactStore.authorizationStatus(for: .contacts) == .authorized
    }
    
    static private func requestAccessToContactsIfNeeded(_ application: UIApplication)
    {
        guard CNContactStore.authorizationStatus(for: .contacts) == .notDetermined else { return }
        
        CNContactStore().requestAccess(for: .contacts) { (granted: Bool, error: Error?) in
            if granted {
                DispatchQueue.main.async {
                    setDynamicShortcutItems(for: application)
                }
            }
        }
    }
}


