//
//  GroupRouter.swift
//  VKClient
//
//  Created by Pavel Olegovich on 07.11.2021.
//

import Foundation
import Alamofire

enum GroupRouter: URLRequestConvertible {
    
    case getGroup
    case searchGroup(textSearch: String)
    
    private var token: String {
        return SessionInfo.shared.token
    }
    
    private var url: URL {
        return URL(string: "https://api.vk.com/method")!
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getGroup: return .get
        case .searchGroup: return .get
        }
    }
    
    private var path: String {
        switch self {
        case .getGroup: return "/groups.get"
        case .searchGroup: return "/groups.search"
        }
    }
    
    private var parameters: Parameters {
        switch self {
        case .getGroup: return [
            "access_token" : token,
            "fields" : "activity",
            "extended" : 1,
            "v" : "5.131"]
        case .searchGroup(let textSearch): return [
            "access_token": token,
            "q": textSearch,
            "v": "5.131"]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = url.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        print(token)
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
