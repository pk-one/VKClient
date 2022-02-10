//
//  NewsRouter.swift
//  VKClient
//
//  Created by Pavel Olegovich on 11.11.2021.
//

import Foundation
import Alamofire

enum NewsRouter: URLRequestConvertible {
    
case getNews
case getComments(ownerId: Int, postId: Int)
case getCommentsUsers(ownerId: Int, postId: Int)
case getCommentsGroups(ownerId: Int, postId: Int)
    
    private var token: String {
        return SessionInfo.shared.token
    }
    
    private var url: URL {
        return URL(string: "https://api.vk.com/method")!
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getNews: return .get
        case .getComments: return .get
        case .getCommentsUsers: return .get
        case .getCommentsGroups: return .get
        }
    }
    
    private var path: String {
        switch self {
        case .getNews: return "/newsfeed.get"
        case .getComments, .getCommentsUsers, .getCommentsGroups: return "/wall.getComments"
        }
    }
    
    private var parameters: Parameters {
        switch self {
        case .getNews: return [
            "access_token" : token,
            "filters": "post, photo",
            "v" : "5.131"
        ]
            
        case .getComments(let ownerId, let postId),
                .getCommentsUsers(let ownerId, let postId),
                .getCommentsGroups(let ownerId, let postId): return [
                    "access_token" : token,
                    "owner_id" : "\(ownerId)",
                    "post_id" : "\(postId)",
                    "sort" : "desc",
                    "extended" : 1,
                    "v" : "5.131"
                ]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = url.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
