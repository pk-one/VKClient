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

extension Group {
    static let groupAllCases = [
        Group(image: "group-1", groupName: "GeekBrains", description: "Образование", countFollowers: 23500, statusGroup: .open),
        Group(image: "group-2", groupName: "SwiftMe", description: "Образование", countFollowers: 773, statusGroup: .open),
        Group(image: "group-3", groupName: "FUN", description: "Юмор", countFollowers: 4446752, statusGroup: .open),
        Group(image: "group-4", groupName: "Blog For Men", description: "Бизнес", countFollowers: 489623, statusGroup: .close),
        Group(image: "group-5", groupName: "Хитрости жизни", description: "Творчество", countFollowers: 3311974, statusGroup: .open)
    ]
}
