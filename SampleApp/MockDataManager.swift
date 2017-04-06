//
//  MockDataManager.swift
//  SampleApp
//
//  Created by Nabiilah Fasih on 4/5/17.
//  Copyright © 2017 PointClickCare. All rights reserved.
//

import UIKit

struct Friend
{
    var identifier: String
    var name: String
}

struct Chat
{
    var sender: Friend
    var image: UIImage
}

class MockDataManager: NSObject
{
    static let shared = MockDataManager()
    
    private(set) var chats = [Chat]()
    private(set) var friends = [Friend]()
    private(set) var topFriends = [Friend]()
    
    private override init()
    {
        super.init()
        self.createSampleData()
    }
    
    private func createSampleData()
    {
        friends = [Friend(identifier: "1", name: "John Smith"),
                   Friend(identifier: "2", name: "Jane Doe"),
                   Friend(identifier: "3", name: "Nick Jones"),
                   Friend(identifier: "4", name: "Lexi Torres"),
                   Friend(identifier: "5", name: "Peter Urso")]
        
        topFriends = [friends[0], friends[1]]
        
        for (index, friend) in friends.enumerated()
        {
            chats.append(Chat(sender: friend, image: UIImage(named: "ChatImage-\(index+1).jpg")!))
        }
    }
    
    func friend(for identifier: String) -> Friend?
    {
        return friends.first { (friend: Friend) -> Bool in
            return friend.identifier == identifier
        }
    }
}
