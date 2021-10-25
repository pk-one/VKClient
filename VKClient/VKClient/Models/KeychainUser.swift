//
//  KeychainUser.swift
//  VKClient
//
//  Created by Pavel Olegovich on 16.09.2021.
//

import Foundation

struct KeychainUser: Codable {
    let id: Int
    let token: String
    let date: TimeInterval
}
