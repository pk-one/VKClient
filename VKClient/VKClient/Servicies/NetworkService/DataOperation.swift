//
//  DataOperation.swift
//  VKClient
//
//  Created by Pavel Olegovich on 07.11.2021.
//

import Foundation
import RealmSwift

class DataOperation {
    
    private var operationQueue = OperationQueue()
    private var databaseService: DatabaseService = DatabaseServiceImplementation()
    
    //MARK:- GetGroups
    func getGroup() {
        let getGroup = GetGroupOperation()
        let parseGroup = ParseGroupOperation { [weak self] groups in
            OperationQueue.main.addOperation {
                _ = try? self?.databaseService.save(groups)
            }
        }
        let operations = [getGroup, parseGroup]
        parseGroup.addDependency(getGroup)
        operationQueue.addOperations(operations, waitUntilFinished: false)
    }
    
    //MARK: - GroupsSearch
    func getGroupSearch(textSearch: String, handler: @escaping ([MyGroups]) -> Void) {
        let getGroup = GetSearchGroupOperation(textSearch: textSearch)
        let parseGroup = ParseSearchGroupOperation { group in
            OperationQueue.main.addOperation {
                handler(group)
            }
        }
        let operations = [getGroup, parseGroup]
        parseGroup.addDependency(getGroup)
        operationQueue.addOperations(operations, waitUntilFinished: false)
    }
    
    //MARK: - getFriends
    func getFriends() {
        let getFriends = GetFriendsOperation()
        let parseFriends = ParseFriendsOperation { [weak self] friends in
            OperationQueue.main.addOperation {
                _ = try? self?.databaseService.save(friends)
            }
        }
        let operations = [getFriends, parseFriends]
        parseFriends.addDependency(getFriends)
        operationQueue.addOperations(operations, waitUntilFinished: false)
    }
    
    //MARK: - GetPhotos
    func getPhotosUser(ownerId: Int, handler: @escaping ([Photos]) -> Void) {
        let getPhotosUser = GetPhotosUserOperation(ownerId: ownerId)
        let parsePhotosUser = ParsePhotosUserOperation { photos in
            OperationQueue.main.addOperation {
                handler(photos)
            }
        }
        let operations = [getPhotosUser, parsePhotosUser]
        parsePhotosUser.addDependency(getPhotosUser)
        operationQueue.addOperations(operations, waitUntilFinished: false)
    }
    
    //MARK: - GetNews
    func getNews() {
        let getNews = GetNewsOperation()
        let parseNews = ParseNewsOperation {[weak self] news in
            OperationQueue.main.addOperation {
                _ = try? self?.databaseService.save(news)
            }
        }
        let operations = [getNews, parseNews]
        parseNews.addDependency(getNews)
        operationQueue.addOperations(operations, waitUntilFinished: false)
    }
    
    //MARK: - GetComments
    func getComments(ownerId: Int, postId: Int) {
        let getComments = GetCommentsOperation(ownerId: ownerId, postId: postId)
        let parseComments = ParseCommentsOperation { [weak self] comments in
            OperationQueue.main.addOperation {
                _ = try? self?.databaseService.save(comments)
            }
        }
        let operations = [getComments, parseComments]
        parseComments.addDependency(getComments)
        operationQueue.addOperations(operations, waitUntilFinished: false)
    }
    
    //MARK: - GetUsersComments
    func getUsersComments(ownerId: Int, postId: Int) {
        let getUsersComments = GetUsersCommentsOperation(ownerId: ownerId, postId: postId)
        let parseUsersComments = ParseCommentsOperation { [weak self] users in
            OperationQueue.main.addOperation {
                _ = try? self?.databaseService.save(users)
            }
        }
        let operations = [getUsersComments, parseUsersComments]
        parseUsersComments.addDependency(getUsersComments)
        operationQueue.addOperations(operations, waitUntilFinished: false)
    }
    
    //MARK: - GetGroupsComments
    func getGroupsComments(ownerId: Int, postId: Int) {
        let getGroupsComments = GetGroupsCommentsOperation(ownerId: ownerId, postId: postId)
        let parseGroupsComments = ParseGroupsCommentsOperation { [weak self] groups in
            OperationQueue.main.addOperation {
                _ = try? self?.databaseService.save(groups)
            }
        }
        let operations = [getGroupsComments, parseGroupsComments]
        parseGroupsComments.addDependency(getGroupsComments)
        operationQueue.addOperations(operations, waitUntilFinished: false)
    }
}
