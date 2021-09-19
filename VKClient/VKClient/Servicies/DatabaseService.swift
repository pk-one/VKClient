//
//  DatabaseService.swift
//  VKClient
//
//  Created by Pavel Olegovich on 19.09.2021.
//

import Foundation
import RealmSwift

protocol DatabaseService {
    func save<T: Object>(_ items: [T]) throws -> Realm
    func save<T: Object>(_ item: T) throws -> Realm
    func get<T: Object, KeyType>(_ type: T.Type, primaryKey: KeyType) throws -> T?
    func get<T: Object>(_ type: T.Type) throws -> Results<T>
    func delete<T: Object>(_ item: T) throws -> Realm
    func deleteAll() throws
}

class DatabaseServiceImplementation: DatabaseService {
    //сохранение последовательности объектов в базу реалм
        func save<T: Object>(_ items: [T]) throws -> Realm {
            let realm = try Realm(configuration: .defaultConfiguration)
            try realm.write {
                realm.add(items, update: .modified)
            }
            return realm
        }
    //сохранение объекта в базу реалм
        func save<T: Object>(_ item: T) throws -> Realm {
            let realm = try Realm(configuration: .defaultConfiguration)
            try realm.write {
                realm.add(item)
            }
            return realm
        }
        
    //получение объекта из базы по ключу
        func get<T: Object, KeyType>(_ type: T.Type, primaryKey: KeyType) throws -> T?{
            let realm = try Realm(configuration: .defaultConfiguration)
            return realm.object(ofType: type, forPrimaryKey: primaryKey)
        }
        
    //получение объектов из базы
        func get<T: Object>(_ type: T.Type) throws -> Results<T> {
            let realm = try Realm(configuration: .defaultConfiguration)
            return realm.objects(type)
        }
    
//    получение объектов по владельцу
//    func get<T: Object, KeyType>(_ type: T.Type, ownerId: KeyType) throws -> Results<T> {
//        let realm = try Realm(configuration: .defaultConfiguration)
//        return realm.object(ofType: type, forPrimaryKey: ownerId)
//    }
    
        
    //удаление объекта из базы
        func delete<T: Object>(_ item: T) throws -> Realm {
            let realm = try Realm(configuration: .defaultConfiguration)
            try realm.write {
                realm.delete(item)
            }
            return realm
        }
        
    //удаление всех объектов из базы данных
        func deleteAll() throws {
            let realm = try Realm(configuration: .defaultConfiguration)
            try realm.write {
                realm.deleteAll()
            }
        }
    }

