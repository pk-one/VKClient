//
//  Photos.swift
//  VKClient
//
//  Created by Pavel Olegovich on 07.09.2021.
//

import Foundation

struct Photos: Codable {
    let response: PhotosResponse
}

struct PhotosResponse: Codable {
    let items: [PhotosItems]
}

struct PhotosItems: Codable {
    let id: Int
    let ownerId: Int
    let sizes: [PhotoUrl]
    let likes: PhotoLikes
    
    struct PhotoUrl: Codable {
        let url: String?
    }
    
    struct PhotoLikes: Codable {
        let count: Int
    }
    
    enum CodingKeys: String, CodingKey {
        case ownerId = "owner_id"
        case id, sizes, likes
    }
}
