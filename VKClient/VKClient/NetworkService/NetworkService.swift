//
//  NetworkService.swift
//  VKClient
//
//  Created by Pavel Olegovich on 29.08.2021.
//

import Foundation
import Alamofire

protocol NetworkService {
    func getFriends(token: String)
    func getGroup(token: String)
    func getGroupSearch(token: String, textSearch: String)
    func getPhotos(token: String, albumId: AlbumID)
}

enum AlbumID {
    case wall
    case profile
    case saved
}

class NetworkServiceImplementation: NetworkService {
    
    private let host = "https://api.vk.com"
    
    let session: Session = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60
        return Session(configuration: config)
    }()
    
    func getFriends(token: String) {
        let path = "/method/friends.get"
        let params: Parameters = [
            "access_token" : token,
            "order" : "hints",
            "fields" : "nickname, sex, bdate, city, country, photo_50, online",
            "v" : "5.131"
        ]
        session.request(host + path, method: .get, parameters: params).responseJSON { response in
            print(response.value)
        }
    }
    
    func getGroup(token: String) {
        let path = "/method/groups.get"
        let params: Parameters = [
            "access_token" : token,
            "extended" : 1,
            "v" : "5.131"
        ]
        session.request(host + path, method: .get, parameters: params).responseJSON { response in
            print(response.value)
        }
    }
    
    func getGroupSearch(token: String, textSearch: String) {
        let path = "/method/groups.search"
        let params: Parameters = [
            "access_token" : token,
            "q" : textSearch,
            "v" : "5.131"
        ]
        session.request(host + path, method: .get, parameters: params).responseJSON { response in
            print(response.value)
        }
    }
    
    func getPhotos(token: String, albumId: AlbumID) {
        let path = "/method/photos.get"
        let params: Parameters = [
        "access_token" : token,
        "extended" : 1,
        "album_id" : albumId,
        "v" : "5.131"
        ]
        session.request(host + path, method: .get, parameters: params).responseJSON { response in
            print(response.value)
        }
    }
    
}
