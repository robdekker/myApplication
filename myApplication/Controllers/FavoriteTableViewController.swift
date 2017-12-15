//
//  FavoriteTableViewController.swift
//  myApplication
//
//  Created by Rob Dekker on 07-12-17.
//  Copyright © 2017 Rob Dekker. All rights reserved.
//

import UIKit
import Firebase

protocol AddToFavoritesDelegate {
    func added(player: Player)
}

class FavoriteTableViewController: UITableViewController, AddToFavoritesDelegate {

    // Properties
    var favorites: [Player] = []
    var user: User!
    
    // Constants
    let ref = Database.database().reference(withPath: "players")
    let usersRef = Database.database().reference(withPath: "online")
    
    // Functions
    func added(player: Player) {
        favorites.append(player)
        let count = favorites.count
        let indexPath = IndexPath(row: count-1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        updateBadgeNumber()
    }
    
    func updateBadgeNumber() {
        let badgeValue = favorites.count > 0 ? "\(favorites.count)" : nil
        navigationController?.tabBarItem.badgeValue = badgeValue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        
        Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            self.user = User(authData: user)
            
            let currentUserRef = self.usersRef.child(self.user.uid)
            currentUserRef.setValue(self.user.email)
            currentUserRef.onDisconnectRemoveValue()
        }
        
//        //observing the data changes
//        ref.observe(DataEventType.value, with: { (snapshot) in
//
//            //if the reference have some values
//            if snapshot.childrenCount > 0 {
//
//                //clearing the list
//                self.favorites.removeAll()
//
//                //iterating through all the values
//                for players in snapshot.children.allObjects as! [DataSnapshot] {
//                    //getting values
//                    let playerObject = players.value as? [String: Any]
//                    let playerName = playerObject?["playerName"]
//                    let position = playerObject?["position"]
//                    let jerseyNumber = playerObject?["jerseyNumber"]
//                    let dateOfBirth = playerObject?["dateOfBirth"]
//                    let nationality = playerObject?["nationality"]
//                    let contractUntil = playerObject?["contractUntil"]
//                    let addedByUser = playerObject?["addedByUser"]
//
//                    print(playerName, position, jerseyNumber, dateOfBirth, nationality, contractUntil, addedByUser)
//                    //creating artist object with model and fetched values
//                    let player = Player(playerName: playerName as! String, position: position as! String, jerseyNumber: jerseyNumber as! Int, dateOfBirth: dateOfBirth as! String, nationality: nationality as! String, contractUntil: contractUntil as! String, favorite: true)
//
//                    //appending it to list
//                    self.favorites.append(player)
//                }
//
//                //reloading the tableview
//                self.tableView.reloadData()
//            }
//        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteItemCell", for: indexPath)
        let favoriteItem = favorites[indexPath.row]
        
        cell.textLabel?.text = favoriteItem.playerName
        cell.detailTextLabel?.text = self.user.email
                
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let favoriteItem = favorites[indexPath.row]
            ref.child(favoriteItem.playerName).setValue(nil)
            
            //let toggledFavorite = favoriteItem.favorite
            //ref.child(favoriteItem.playerName).updateChildValues([
            //    "favorite": toggledFavorite
            //    ])
            
            favorites.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateBadgeNumber()
            
        }
    }
}
