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
            guard let self = self else { return }
            OperationQueue.main.addOperation {
                _ = try? self.databaseService.save(groups)
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
            guard let self = self else { return }
            OperationQueue.main.addOperation {
                _ = try? self.databaseService.save(friends)
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
}
