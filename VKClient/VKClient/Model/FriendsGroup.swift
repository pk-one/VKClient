//
//  FriendsGroup.swift
//  VKClient
//
//  Created by Pavel Olegovich on 01.08.2021.
//

import Foundation

class GroupFriends {
    var firstLetter: String
    var friends: [Friends]

    init(firstLetter: String, friends: [Friends]) {
        self.firstLetter = firstLetter
        self.friends = friends
    }
}
