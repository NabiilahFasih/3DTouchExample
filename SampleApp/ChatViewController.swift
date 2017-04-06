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
        
        //1- Need to register for previewing
        registerForPreviewing(with: self, sourceView: tableView)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        
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
        if let chatDetailsVC = segue.destination as? ChatDetailsViewController, let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell)
        {
            chatDetailsVC.chat = chat(at: indexPath)
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

//2 - Conform to UIViewControllerPreviewingDelegate
extension ChatViewController : UIViewControllerPreviewingDelegate
{
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController?
    {
        guard let indexPath = tableView.indexPathForRow(at: location) else { return nil }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let chatDetailsVC = storyboard.instantiateViewController(withIdentifier: "ChatDetailsViewController") as!ChatDetailsViewController
        chatDetailsVC.chat = chat(at: indexPath)
        
        //3 - Specify source rect
        let cellRect = tableView.rectForRow(at: indexPath)
        previewingContext.sourceRect = previewingContext.sourceView.convert(cellRect, from: tableView)
        
        //4 - Return previewing VC
        return chatDetailsVC
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController)
    {
        //5 - Show the VC, using any animation
        show(viewControllerToCommit, sender: self)
    }
}

