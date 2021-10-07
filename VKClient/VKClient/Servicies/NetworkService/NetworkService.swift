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
import FirebaseFirestore

protocol NetworkService {
    func getNews(completionHandler: @escaping (Result<[RealmNews], Error>) -> Void)
    func getCommentsNewsfeed(ownerId: Int, postId: Int, completionHandler: @escaping (Result<[RealmNewsfeedComments], Error>) -> Void)
    func getFriends(completionHandler: @escaping (Result<[RealmFriends], Error>) -> Void)
    func getPhotos(ownerId: Int, completionHandler: @escaping ([Photos]) -> Void)
    func getGroup(completionHandler: @escaping (Result<[RealmGroups], Error>) -> Void)
    func getGroupSearch(textSearch: String, completionHandler: @escaping ([MyGroups]) -> Void)
    func getCommentsUsers(ownerId: Int, postId: Int, completionHandler: @escaping (Result<[RealmCommentsUsers], Error>) -> Void)
    func getCommentsGroups(ownerId: Int, postId: Int, completionHandler: @escaping (Result<[RealmCommentsGroups], Error>) -> Void)
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
            "fields" : "activity",
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
                let groups = groupsItems.map { MyGroups($0) }
                let realmGroups = groups.map { RealmGroups($0) }
                completionHandler(.success(realmGroups))
            }
        }
    }
    
    //MARK: - GroupsSearch
    func getGroupSearch(textSearch: String, completionHandler: @escaping ([MyGroups]) -> Void) {
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
                let searchGroups = groupsSearchItems.map { MyGroups($0) }
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
                completionHandler([])
            case .success(let value):
                let json = JSON(value)
                let photosItems = json["response"]["items"].arrayValue
                let photos = photosItems.map { Photos($0) }
                completionHandler(photos)
            }
        }
    }
    
    //MARK: GetCommentsNewsfeed
    func getCommentsNewsfeed(ownerId: Int, postId: Int, completionHandler: @escaping (Result<[RealmNewsfeedComments], Error>) -> Void) {
        let path = "/method/wall.getComments"
        let params: Parameters = [
            "access_token" : token,
            "owner_id" : "\(ownerId)",
            "post_id" : "\(postId)",
            "sort" : "desc",
            "extended" : 1,
            "v" : "5.131"
        ]
        session.request(host + path, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let value):
                let json = JSON(value)
                let commentsItems = json["response"]["items"].arrayValue
                let comments = commentsItems.map { NewsfeedComments($0) }
                let realmComments = comments.map { RealmNewsfeedComments($0) }
                completionHandler(.success(realmComments))
            }
            
        }
    }
    
    //MARK: GetUsersComments
    func getCommentsUsers(ownerId: Int, postId: Int, completionHandler: @escaping (Result<[RealmCommentsUsers], Error>) -> Void) {
        let path = "/method/wall.getComments"
        let params: Parameters = [
            "access_token" : token,
            "owner_id" : "\(ownerId)",
            "post_id" : "\(postId)",
            "sort" : "desc",
            "extended" : 1,
            "v" : "5.131"
        ]
        session.request(host + path, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let value):
                let json = JSON(value)
                let commentsUser = json["response"]["profiles"].arrayValue
                let users = commentsUser.map { UsersComments($0) }
                let realmUsers = users.map { RealmCommentsUsers($0) }
                completionHandler(.success(realmUsers))
            }
        }
    }
    
    //MARK: GetGroupsComments
    func getCommentsGroups(ownerId: Int, postId: Int, completionHandler: @escaping (Result<[RealmCommentsGroups], Error>) -> Void) {
        let path = "/method/wall.getComments"
        let params: Parameters = [
            "access_token" : token,
            "owner_id" : "\(ownerId)",
            "post_id" : "\(postId)",
            "sort" : "desc",
            "extended" : 1,
            "v" : "5.131"
        ]
        session.request(host + path, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let value):
                let json = JSON(value)
                let commentsGroups = json["response"]["groups"].arrayValue
                let groupsComments = commentsGroups.map { GroupsComments($0) }
                let realmCommentsGroups = groupsComments.map { RealmCommentsGroups($0) }
                completionHandler(.success(realmCommentsGroups))
            }
        }
    }
}
