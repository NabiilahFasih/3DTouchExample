//
//  ViewController.swift
//  SampleApp
//
//  Created by Nabiilah Fasih on 4/5/17.
//  Copyright © 2017 PointClickCare. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        if let selectedIndexPaths = tableView.indexPathsForSelectedRows
        {
            for selectedIndexPath in selectedIndexPaths
            {
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        }
    }
    
    fileprivate func chat(at indexPath: IndexPath) -> Chat
    {
        return MockDataManager.shared.chats[indexPath.row]
    }
    
    @IBAction func composeButtonTapped(_ sender: Any)
    {
        composeNewChat(to: nil)
    }
    
    func composeNewChat(to friend: Friend?)
    {
        var message: String
        if let friend = friend
        {
            message = "This is where we'd send the chat to your friend \(friend.name)."
        }
        else
        {
            message = "This is where you'd choose a friend, and then we'd send the chat to them."
        }
        
        let alertViewController = UIAlertController(title: "New Chat", message: message, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alertViewController, animated: true, completion: nil);
    }
}

extension ChatViewController
{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let chatDetailsVC = segue.destination as? ChatDetailsViewController, let selectedIndexPath = tableView.indexPathForSelectedRow
        {
            chatDetailsVC.chat = chat(at: selectedIndexPath)
        }
    }
}

extension ChatViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return MockDataManager.shared.chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let item = chat(at: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath)
        cell.textLabel?.text = "Chat from \(item.sender.name)"
        return cell
    }
}

