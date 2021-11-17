//
//  Groups.swift
//  VKClient
//
//  Created by Pavel Olegovich on 02.09.2021.
//

import Foundation

struct Groups: Codable {
    let response: GroupsResponse
}

struct GroupsResponse: Codable {
    let items: [GroupsItems]
}

struct GroupsItems: Codable {
    let id: Int
    let name: String?
    let avatar: String
    let activity: String?
    
    enum CodingKeys: String, CodingKey {
        case avatar = "photo_50"
        case id, name, activity
    }
}
