//
//  Sessin.swift
//  VKClient
//
//  Created by Pavel Olegovich on 27.08.2021.
//

import Foundation

class SessionInfo {
    private init() { }
    
    static let shared = SessionInfo()
    //MARK: - User info
    var token: String?
    var userId: Int?
}
