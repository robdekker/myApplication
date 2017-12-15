//
//  PlayerTableViewController.swift
//  myApplication
//
//  Created by Rob Dekker on 06-12-17.
//  Copyright © 2017 Rob Dekker. All rights reserved.
//

import UIKit
import Firebase

class PlayerTableViewController: UITableViewController {
    
    // Constants
    let usersRef = Database.database().reference(withPath: "online")
    
    // Properties
    var user: User!
    var players = [Player]()
    var userCountBarButtonItem: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userCountBarButtonItem = UIBarButtonItem(title: "1",
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(userCountButtonDidTouch))
        userCountBarButtonItem.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = userCountBarButtonItem
    
        // Update userCountBarButtonItem
        usersRef.observe(.value, with: { snapshot in
            if snapshot.exists() {
                self.userCountBarButtonItem?.title = snapshot.childrenCount.description
            } else {
                self.userCountBarButtonItem?.title = "0"
            }
        })

        Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            self.user = User(authData: user)
            
            let currentUserRef = self.usersRef.child(self.user.uid)
            currentUserRef.setValue(self.user.email)
            currentUserRef.onDisconnectRemoveValue()
        }
        
        //getData()
        ItemController.shared.fetchPlayers { (players) in
            if let players = players {
                self.updateUI(with: players)
            }
        }
        
    }
    
    func updateUI(with players: [Player]) {
        DispatchQueue.main.async {
            self.players = players
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        configure(cell: cell, forItemAt: indexPath)
        
        return cell
    }
    
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let playerString = players[indexPath.row]
        cell.textLabel?.text = playerString.playerName
        cell.detailTextLabel?.text = playerString.position
    }

    // MARK: - Navigation
    
    // Prepare segue to PlayerDetailViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "listToDetail" {
            let playerDetailViewController = segue.destination as! PlayerDetailViewController
            let index = tableView.indexPathForSelectedRow!.row
            playerDetailViewController.player = players[index]
        }
    }
    
    @objc func userCountButtonDidTouch() {
        performSegue(withIdentifier: "listToUsers", sender: nil)
    }

}
