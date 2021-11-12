//
//  ParseGroupOperation.swift
//  VKClient
//
//  Created by Pavel Olegovich on 07.11.2021.
//

import Foundation
import SwiftyJSON

class ParseGroupOperation: Operation {
    
    private let completion: ([RealmGroups]) -> Void
    
    init(completion: @escaping ([RealmGroups]) -> Void) {
        self.completion = completion
    }
    
    override func main() {
        guard let getGroupOperation = dependencies.first as? GetGroupOperation,
              let data = getGroupOperation.data else { return }
        let json = JSON(data)
        let groupsItems = json["response"]["items"].arrayValue
        let groups = groupsItems.map { MyGroups($0) }
        let realmGroups = groups.map { RealmGroups($0) }
            completion(realmGroups)
    }
}
