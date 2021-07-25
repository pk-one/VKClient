//
//  User.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.07.2021.
//

import Foundation
import UIKit

struct User {
    enum Gender: String {
        case male = "Мужчина"
        case female = "Женщина"
    }
    
    let avatarImage: String
    let photos: [String]
    let firstName: String
    let secondName: String
    let gender: Gender
    var fullName: String {
        return firstName + " " + secondName
    }
}

func getUser() -> [User]{
    let data: [(String, [String], String, String, User.Gender, Int)] =
                                                             [("user-1", ["user-1-1", "user-1-2"], "Джаред", "Летто", .male, 65),
                                                              ("user-2", ["user-2-1", "user-2-2", "user-2-3"], "Марк", "Уолберг", .male, 50),
                                                              ("user-3", ["user-3-1", "user-3-2"], "Джереми", "Реннер", .male, 47),
                                                              ("user-4", ["user-4-1", "user-4-2"], "Илон", "Маск", .male, 62)]
    
    var users = [User]()
    
    for i in 0..<data.count {
        let user = User (
            avatarImage: data[i].0,
            photos: data[i].1,
            firstName: data[i].2,
            secondName: data[i].3,
            gender: data[i].4
        )
        users.append(user)
    }
    return users
}



