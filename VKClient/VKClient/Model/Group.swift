//
//  Group.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.07.2021.
//

import Foundation
import UIKit

struct Group {
    enum Status: String {
        case open = "Открытая"
        case close = "Закрытая"
    }
    let image: String
    let groupName: String
    let description: String
    let countFollowers: Int
    let statusGroup: Status
}

extension Group : Equatable {
    static func == (lhs: Group, rhs: Group) -> Bool {
        return lhs.groupName == rhs.groupName
    }
}


func getAllGroups() -> [Group] {
    
    let data: [(String, String, String, Int, Group.Status)] = [("group-1", "GeekBrains", "Образование", 23500, .open), ("group-2", "SwiftMe", "Образование", 773, .open), ("group-3", "FUN", "Юмор", 4446752, .open), ("group-4", "Blog For Men", "Бизнес", 489623, .close), ("group-5", "Хитрости жизни", "Творчество", 3311974, .open)]
    
    var groups = [Group]()
    
    for i in 0 ..< data.count {
        let group = Group(
            image: data[i].0,
            groupName: data[i].1,
            description: data[i].2,
            countFollowers: data[i].3,
            statusGroup: data[i].4
        )
        groups.append(group)
    }
    return groups
}
