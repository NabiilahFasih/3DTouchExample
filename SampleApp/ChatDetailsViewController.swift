//
//  ChatDetailsViewController.swift
//  SampleApp
//
//  Created by Nabiilah Fasih on 4/5/17.
//  Copyright © 2017 PointClickCare. All rights reserved.
//

import UIKit

class ChatDetailsViewController: UIViewController
{
    @IBOutlet weak var imageView: UIImageView!
    
    var chat: Chat!
    {
        didSet
        {
            imageView?.image = chat.image
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Chat from \(chat.sender.name)"
        imageView?.image = chat.image
    }
}
