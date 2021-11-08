//
//  ParseFriendsOperation.swift
//  VKClient
//
//  Created by Pavel Olegovich on 07.11.2021.
//

import Foundation
import SwiftyJSON

class ParseFriendsOperation: Operation {
    
    private let completion: ([RealmFriends]) -> Void
    
    init(completion: @escaping ([RealmFriends]) -> Void) {
        self.completion = completion
    }
    
    override func main() {
        guard let getFriendsOperation = dependencies.first as? GetFriendsOperation,
              let data = getFriendsOperation.data else { return }
        let json = JSON(data)
        let friendsItems = json["response"]["items"].arrayValue
        let friends = friendsItems.map { Friends($0) }
        let realmFriends = friends.map { RealmFriends($0) }
            completion(realmFriends)
    }
}
