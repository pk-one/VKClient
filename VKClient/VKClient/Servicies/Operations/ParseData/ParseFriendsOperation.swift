//
//  ParseFriendsOperation.swift
//  VKClient
//
//  Created by Pavel Olegovich on 07.11.2021.
//

import Foundation

class ParseFriendsOperation: Operation {
    
    private let completion: ([RealmFriends]) -> Void
    
    init(completion: @escaping ([RealmFriends]) -> Void) {
        self.completion = completion
    }
    
    override func main() {
        guard let getFriendsOperation = dependencies.first as? GetFriendsOperation,
              let data = getFriendsOperation.data else { return }
        
        do {
            let friends = try JSONDecoder().decode(Friends.self, from: data)
                        
            let realmFriends = friends.response.items.map { RealmFriends($0) }
                completion(realmFriends)
        } catch let jsonError {
            print(jsonError)
        }
    }
}
