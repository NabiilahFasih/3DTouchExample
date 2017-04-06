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
    
    //DEMO - Adding preview action items
//    override var previewActionItems: [UIPreviewActionItem]
//    {
//        let handler = {(action: UIPreviewAction, viewController: UIViewController) -> Void in
//            //Does nothing for now - this is where you'd add something to happen
//        }
//        
//        //"Send Reply" action with a group of possible replies
//        let replyActions = [UIPreviewAction(title: "❤️", style: .default, handler: handler),
//                            UIPreviewAction(title: "😄", style: .default, handler: handler),
//                            UIPreviewAction(title: "👍", style: .default, handler: handler),
//                            UIPreviewAction(title: "😯", style: .default, handler: handler),
//                            UIPreviewAction(title: "😢", style: .default, handler: handler),
//                            UIPreviewAction(title: "😈", style: .default, handler: handler)]
//        let sendReply = UIPreviewActionGroup(title: "Send Reply...", style: .default, actions: replyActions)
//        
//        //"Favorite" action with style selected
//        let favorite = UIPreviewAction(title: "Favorite", style: .selected, handler: handler)
//        
//        //"Block" action with style destructive
//        let block = UIPreviewAction(title: "Block", style: .destructive, handler: handler)
//        
//        return [sendReply, favorite, block]
//    }
}
