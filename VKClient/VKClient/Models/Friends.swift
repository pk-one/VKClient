//
//  Friends.swift
//  VKClient
//
//  Created by Pavel Olegovich on 05.09.2021.
//

import Foundation

struct Friends: Codable {
    let response: FriendsResponse
}

struct FriendsResponse: Codable {
    let items: [FriendsItems]
}

struct FriendsItems: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let online: Int
    let avatar: String
    let city: City?
    
    struct City: Codable {
        let title: String
    }
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "photo_50"
        case id, online, city
    }
}

