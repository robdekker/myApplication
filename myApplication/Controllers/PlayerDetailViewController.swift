//
//  PlayerDetailViewController.swift
//  myApplication
//
//  Created by Rob Dekker on 07-12-17.
//  Copyright © 2017 Rob Dekker. All rights reserved.
//

import UIKit
import Firebase

class PlayerDetailViewController: UIViewController {

    // Outlets
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var jerseyNumberLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var contractUntilLabel: UILabel!
    
    @IBOutlet weak var addToFavoritesButton: UIButton!
    
    // Actions
    @IBAction func addToFavoritesButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.2) {
            self.addToFavoritesButton.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            self.addToFavoritesButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        
        let toggledFavorite = !player.favorite
        
        if player.favorite != true {
            delegate?.added(player: player)
            player.favorite = toggledFavorite
            
            ref.child(player.playerName).setValue([
                "playerName": player.playerName,
                "position": player.position,
                "jerseyNumber": player.jerseyNumber,
                "dateOfBirth": player.dateOfBirth,
                "nationality": player.nationality,
                "contractUntil": player.contractUntil,
                "favorite": toggledFavorite,
                "addedByUser": self.user.email
                ])
            
            // change title and state of add button
            addToFavoritesButton.setTitle("Unfavorite", for: .normal)
            //addToFavoritesButton.isUserInteractionEnabled = false
        } else {
            ref.child(player.playerName).updateChildValues([
                "favorite": !toggledFavorite
                ])
            addToFavoritesButton.setTitle("Add To Favorites", for: .normal)
        }
    }
    
    // Properties
    var player: Player!
    var user: User!
    var delegate: AddToFavoritesDelegate?
    
    // Constants
    let ref = Database.database().reference(withPath: "players")
    let usersRef = Database.database().reference(withPath: "online")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
        setupDelegate()
        
        Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            self.user = User(authData: user)
            
            let currentUserRef = self.usersRef.child(self.user.uid)
            currentUserRef.setValue(self.user.email)
            currentUserRef.onDisconnectRemoveValue()
        }
    }
    
    func updateUI() {
        playerNameLabel.text = player.playerName
        positionLabel.text = player.position
        // Change jerseyNumber of type Int into a String
        jerseyNumberLabel.text = "\(player.jerseyNumber)"
        dateOfBirthLabel.text = player.dateOfBirth
        nationalityLabel.text = player.nationality
        contractUntilLabel.text = player.contractUntil
    }
    
    func setupDelegate() {
        if let navController = tabBarController?.viewControllers?.last as? UINavigationController,
            let favoriteTableViewController = navController.viewControllers.first as? FavoriteTableViewController {
            delegate = favoriteTableViewController
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
