//
//  UserGroup.swift
//  VKClient
//
//  Created by Pavel Olegovich on 01.08.2021.
//

import Foundation

class GroupUser {
    var firstLetter: String
    var users: [User]

    init(firstLetter: String, users: [User]) {
        self.firstLetter = firstLetter
        self.users = users
    }
}

func groupUsersByFirstLetter() -> [GroupUser]{
    
    let friends = getUser()
    var groupUsers : [GroupUser] = []
    let sorted = friends.sorted {$0.firstName.first! < $1.firstName.first!}
    
    for user in sorted {
        let firstLetter = String(user.firstName.first!)
        if groupUsers.count == 0 {
            groupUsers.append(GroupUser(firstLetter: firstLetter, users: [user]))
        } else {
            if firstLetter == groupUsers.last?.firstLetter {
                groupUsers.last?.users.append(user)
            } else {
                groupUsers.append(GroupUser(firstLetter: firstLetter, users: [user]))
            }
        }
    }
    return groupUsers
}
