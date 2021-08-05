//
//  News.swift
//  VKClient
//
//  Created by Pavel Olegovich on 03.08.2021.
//

import UIKit

private let allUsers = getUser()
private let allGroups = Group.groupAllCases

struct News {
    let imageHeaderNews: String
    let nameAuthorNews: String
    let timeNews: String
    let textNews: String?
    let imageNews: [String]?
    let countLikeNews: Int
    let countCommentsNews: Int
    let countRepostsNews: Int
    let countViewsNews: Int
}

extension News {
    static let allPostCases = [
        News(imageHeaderNews: allUsers[1].avatarImage, nameAuthorNews: allUsers[1].fullName, timeNews: "Вчера в 13:53", textNews: "Всем привет", imageNews: ["news-1-1", "news-1-2", "news-1-3", "news-1-4"], countLikeNews: 15, countCommentsNews: 15, countRepostsNews: 266, countViewsNews: 950),
        News(imageHeaderNews: allGroups[0].image, nameAuthorNews: allGroups[0].groupName, timeNews: "17 июля в 17:14", textNews: "", imageNews: ["news-1-1", "news-1-2", "news-1-3", "news-1-4"], countLikeNews: 3, countCommentsNews: 5, countRepostsNews: 0, countViewsNews: 1548)
    ]
}
