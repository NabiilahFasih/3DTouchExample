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
    
    func createSampleData()
    {
        friends = [Friend(name: "John Smith"),
                   Friend(name: "Jane Doe"),
                   Friend(name: "Nick Jones"),
                   Friend(name: "Lexi Torres"),
                   Friend(name: "Peter Urso")]
        
        topFriends = [friends[0], friends[1]]
        
        for (index, friend) in friends.enumerated()
        {
            chats.append(Chat(sender: friend, image: UIImage(named: "ChatImage-\(index+1).jpg")!))
        }
    }

}
