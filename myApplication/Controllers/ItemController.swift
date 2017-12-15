//
//  ItemController.swift
//  myApplication
//
//  Created by Rob Dekker on 08-12-17.
//  Copyright © 2017 Rob Dekker. All rights reserved.
//

import Foundation

class ItemController {
    
    static let shared = ItemController()

    let baseURL = URL(string: "http://api.football-data.org/v1/")!
    
    func fetchPlayers(completion: @escaping ([Player]?) -> Void) {
        var players = [Player]()
        let playerURL = baseURL.appendingPathComponent("teams/86/players")
        let task = URLSession.shared.dataTask(with: playerURL) { (data, response, error) in
            if let data = data,
                let jsonDictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                let fetchedPlayers = jsonDictionary!["players"] as? [[String: Any]] {
                    for player in fetchedPlayers {
                        if let playerName = player["name"] as? String,
                            let position = player["position"] as? String,
                            let jerseyNumber = player["jerseyNumber"] as? Int,
                            let dateOfBirth = player["dateOfBirth"] as? String,
                            let nationality = player["nationality"] as? String,
                            let contractUntil = player["contractUntil"] as? String {
                            
                            players.append(Player(playerName: playerName, position: position, jerseyNumber: jerseyNumber, dateOfBirth: dateOfBirth, nationality: nationality, contractUntil: contractUntil, favorite: false))
                            completion(players)
                        }
                    }
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
