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

