//
//  FriendsViewModelFactory.swift
//  VKClient
//
//  Created by Pavel Olegovich on 10.02.2022.
//

import Foundation
import Kingfisher

class FriendsViewModelFactory {
    func constructViewModel(from friends: [FriendsItems]) -> [FriendsViewModel] {
        return friends.compactMap(getViewModel)
    }
    
    private func getViewModel(from friend: FriendsItems) -> FriendsViewModel {
        
        let id = friend.id
        
        let avatarUrl = friend.avatar
        
        let cityName = friend.city?.title
        let fullNameFriend = "\(friend.firstName) \(friend.lastName)"
        
        let online = friend.online == 1 ? true : false
   
        return FriendsViewModel(id: id, avatarUrl: avatarUrl, fullName: fullNameFriend, online: online, city: cityName)
    }
}

