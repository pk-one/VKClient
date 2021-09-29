//
//  NetworkService.swift
//  VKClient
//
//  Created by Pavel Olegovich on 29.08.2021.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

protocol NetworkService {
    func getNews(completionHandler: @escaping (Result<[RealmNews], Error>) -> Void)
    func getFriends(completionHandler: @escaping (Result<[RealmFriends], Error>) -> Void)
    func getPhotos(ownerId: Int, completionHandler: @escaping ([Photos]) -> Void)
    func getGroup(completionHandler: @escaping (Result<[RealmGroups], Error>) -> Void)
    func getGroupSearch(textSearch: String, completionHandler: @escaping ([Groups]) -> Void)
}

class NetworkServiceImplementation: NetworkService {
    
    private let host = "https://api.vk.com"
    private let token = SessionInfo.shared.token
    private let databaseService: DatabaseService = DatabaseServiceImplementation()
    
    let session: Session = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60
        return Session(configuration: config)
    }()
    
    
    //MARK: - GetNews
    func getNews(completionHandler: @escaping (Result<[RealmNews], Error>) -> Void) {
        let path = "/method/newsfeed.get"
        let params: Parameters = [
            "access_token" : token,
            "filters": "post, photo",
            "v" : "5.131"
        ]
        session.request(host + path, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let value):
                let json = JSON(value)
                let newsItems = json["response"]["items"].arrayValue
                let news = newsItems.map { News($0) }
                let realmNews = news.map { RealmNews ($0) }
                completionHandler(.success(realmNews))
            }
        }
    }
    
    //MARK: - GetFriends
    func getFriends(completionHandler: @escaping (Result<[RealmFriends], Error>) -> Void) {
        let path = "/method/friends.get"
        let params: Parameters = [
            "access_token" : token,
            "order" : "hints",
            "fields" : "city, photo_50, online",
            "v" : "5.131"
        ]
        session.request(host + path, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let value):
                let json = JSON(value)
                let friendsItems = json["response"]["items"].arrayValue
                let friends = friendsItems.map { Friends($0) }
                let realmFriends = friends.map { RealmFriends($0) }
                completionHandler(.success(realmFriends))
                let realm = try? Realm()
                print(realm?.configuration.fileURL)
            }
        }
    }
    
    //MARK:- GetGroups
    func getGroup(completionHandler: @escaping (Result<[RealmGroups], Error>) -> Void) {
        let path = "/method/groups.get"
        let params: Parameters = [
            "access_token" : token,
            "extended" : 1,
            "v" : "5.131"
        ]
        session.request(host + path, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let value):
                let json = JSON(value)
                let groupsItems = json["response"]["items"].arrayValue
                let groups = groupsItems.map { Groups($0) }
                let realmGroups = groups.map { RealmGroups($0) }
                completionHandler(.success(realmGroups))
            }
        }
    }
    
    //MARK: - GroupsSearch
    func getGroupSearch(textSearch: String, completionHandler: @escaping ([Groups]) -> Void) {
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
    func getPhotos(ownerId: Int, completionHandler: @escaping ([Photos]) -> Void) {
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
