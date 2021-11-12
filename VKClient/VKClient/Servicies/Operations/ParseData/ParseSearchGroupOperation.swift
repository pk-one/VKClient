//
//  ParseSearchGroupOperation.swift
//  VKClient
//
//  Created by Pavel Olegovich on 07.11.2021.
//

import Foundation
import SwiftyJSON

class ParseSearchGroupOperation: Operation {
    
    private let completion: ([MyGroups]) -> Void
    
    init(completion: @escaping ([MyGroups]) -> Void) {
        self.completion = completion
    }
    
    override func main() {
        guard let getGroupOperation = dependencies.first as? GetSearchGroupOperation,
              let data = getGroupOperation.data else { return }
        let json = JSON(data)
        let groupsSearchItems = json["response"]["items"].arrayValue
        let searchGroups = groupsSearchItems.map { MyGroups($0) }
            completion(searchGroups)
    }
}
