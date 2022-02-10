//
//  FriendsAdapter.swift
//  VKClient
//
//  Created by Pavel Olegovich on 10.02.2022.
//

import Foundation
import RealmSwift

class FriendsAdapter {
    private let databaseService: DatabaseService = DatabaseServiceImplementation()
    private let dataOperation = DataOperation()
    private var notificationToken: NotificationToken?
    
    func getFriends(completion: @escaping (Result<[FriendsItems], Error>) -> Void ) {
        dataOperation.getFriends()
        guard let realmFriends = try? databaseService.get(RealmFriends.self) else { return }
        
        notificationToken = realmFriends.observe { [weak self] change in
            guard let self = self else { return }
            switch change {
            case .error(let error):
                completion(.failure(error))
            case .initial(let realmFriends):
                let friends = self.assemblingFriend(realm: realmFriends)
                completion(.success(friends))
            case .update:
                let friends = self.assemblingFriend(realm: realmFriends)
                completion(.success(friends))
            }
        }
    }
    
    private func assemblingFriend(realm: Results<RealmFriends>) -> [FriendsItems] {
        var friends = [FriendsItems]()
        realm.forEach { friendItems in
            let friend = FriendsItems(id: friendItems.id,
                                      firstName: friendItems.firstName,
                                      lastName: friendItems.lastName,
                                      online: friendItems.online,
                                      avatar: friendItems.avatar,
                                      city: FriendsItems.City(title: friendItems.city ?? ""))
            friends.append(friend)
        }
        return friends
    }
}

