//
//  ParseGroupOperation.swift
//  VKClient
//
//  Created by Pavel Olegovich on 07.11.2021.
//

import Foundation

class ParseGroupOperation: Operation {
    
    private let completion: ([RealmGroups]) -> Void
    
    init(completion: @escaping ([RealmGroups]) -> Void) {
        self.completion = completion
    }
    
    override func main() {
        guard let getGroupOperation = dependencies.first as? GetGroupOperation,
              let data = getGroupOperation.data else { return }
        
        do {
            let groups = try JSONDecoder().decode(Groups.self, from: data)
            
            let realmGroups = groups.response.items.map { RealmGroups($0) }
                completion(realmGroups)
        } catch let jsonError {
            print(jsonError)
        }
    }
}
