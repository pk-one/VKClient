//
//  NetworkService.swift
//  VKClient
//
//  Created by Pavel Olegovich on 29.08.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol NetworkService {
    func getFriends(token: String, completionHandler: @escaping ([Friends]) -> Void)
    func getPhotos(token: String, ownerId: Int, completionHandler: @escaping ([Photos]) -> Void)
    func getGroup(token: String, completionHandler: @escaping ([Groups]) -> Void)
    func getGroupSearch(token: String, textSearch: String, completionHandler: @escaping ([Groups]) -> Void)
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
    
    //MARK: - GetFriends
    func getFriends(token: String, completionHandler: @escaping ([Friends]) -> Void) {
        let path = "/method/friends.get"
        let params: Parameters = [
            "access_token" : token,
            "order" : "hints",
            "fields" : "city, photo_50, online",
            "count" : "100",
            "v" : "5.131"
        ]
        session.request(host + path, method: .get, parameters: params).responseJSON { response in
           switch response.result {
           case .failure(let error):
            print(error.localizedDescription)
            completionHandler([])
           case .success(let value):
            let json = JSON(value)
            let friendsItems = json["response"]["items"].arrayValue
            let friends = friendsItems.map { Friends($0) }
            completionHandler(friends)
            }
        }
    }
    //MARK:- GetGroup
    func getGroup(token: String, completionHandler: @escaping ([Groups]) -> Void) {
        let path = "/method/groups.get"
        let params: Parameters = [
            "access_token" : token,
            "extended" : 1,
            "count" : "100",
            "v" : "5.131"
        ]
        session.request(host + path, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler([])
            case .success(let value):
                let json = JSON(value)
                let groupsItems = json["response"]["items"].arrayValue
                let groups = groupsItems.map { Groups($0) }
                completionHandler(groups)
            }
        }
    }
    //MARK: - GroupsSearch
    func getGroupSearch(token: String, textSearch: String, completionHandler: @escaping ([Groups]) -> Void) {
        let path = "/method/groups.search"
        let params: Parameters = [
            "access_token" : token,
            "q" : textSearch,
            "v" : "5.131"
        ]
        session.request(host + path, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case .failure(let error):
            print(error.localizedDescription)
            completionHandler([])
            case .success(let value):
                let json = JSON(value)
                let groupsSearchItems = json["response"]["items"].arrayValue
                let searchGroups = groupsSearchItems.map { Groups($0) }
                completionHandler(searchGroups)
            }
        }
    }
    
    //MARK: - GetPhotos
    func getPhotos(token: String, ownerId: Int, completionHandler: @escaping ([Photos]) -> Void) {
        let path = "/method/photos.get"
        let params: Parameters = [
        "owner_id" : ownerId,
        "access_token" : token,
        "extended" : "1",
        "album_id" : "wall",
        "v" : "5.131"
        ]
        session.request(host + path, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler([])
            case .success(let value):
                let json = JSON(value)
                let photosItems = json["response"]["items"].arrayValue
                let photos = photosItems.map { Photos($0) }
                completionHandler(photos)
            }
        }
    }
}
