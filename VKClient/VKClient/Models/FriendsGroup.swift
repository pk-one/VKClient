//
//  FriendsGroup.swift
//  VKClient
//
//  Created by Pavel Olegovich on 01.08.2021.
//

import Foundation

class GroupFriends {
    var firstLetter: String
    var friends: [RealmFriends]

    init(firstLetter: String, friends: [RealmFriends]) {
        self.firstLetter = firstLetter
        self.friends = friends
    }
}
