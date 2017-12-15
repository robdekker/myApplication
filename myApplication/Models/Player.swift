//
//  Player.swift
//  myApplication
//
//  Created by Rob Dekker on 06-12-17.
//  Copyright © 2017 Rob Dekker. All rights reserved.
//

import Foundation
import Firebase

struct Player {
    
    let playerName: String
    let position: String
    let jerseyNumber: Int
    let dateOfBirth: String
    let nationality: String
    let contractUntil: String
    var favorite: Bool
    let ref: DatabaseReference?

    
    init(playerName: String, position: String, jerseyNumber: Int, dateOfBirth: String, nationality: String, contractUntil: String, favorite: Bool) {
        self.playerName = playerName
        self.position = position
        self.jerseyNumber = jerseyNumber
        self.dateOfBirth = dateOfBirth
        self.nationality = nationality
        self.contractUntil = contractUntil
        self.favorite = favorite
        self.ref = nil
    }
    
    /*
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        playerName = snapshotValue["playerName"] as! String
        position = snapshotValue["position"] as! String
        jerseyNumber = snapshotValue["jerseyNumber"] as! Int
        dateOfBirth = snapshotValue["dateOfBirth"] as! Data
        nationality = snapshotValue["nationality"] as! String
        contractUntil = snapshotValue["contractUntil"] as! Data
        marketValue = snapshotValue["marketValue"] as? Int
        favorite = snapshotValue["favorite"] as! Bool
        ref = snapshot.ref
    }
     */
    
    func toAnyObject() -> Any {
        return [
            "playerName": playerName,
            "position": position,
            "jerseyNumber": jerseyNumber,
            "dateOfBirth": dateOfBirth,
            "nationality": nationality,
            "contractUntil": contractUntil,
            "favorite": favorite
        ]
    }
    
}
