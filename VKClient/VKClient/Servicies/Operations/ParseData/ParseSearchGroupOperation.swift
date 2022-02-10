//
//  ParseSearchGroupOperation.swift
//  VKClient
//
//  Created by Pavel Olegovich on 07.11.2021.
//

import Foundation

class ParseSearchGroupOperation: Operation {
    
    private let completion: ([GroupsItems]) -> Void
    
    init(completion: @escaping ([GroupsItems]) -> Void) {
        self.completion = completion
    }
    
    override func main() {
        guard let getGroupOperation = dependencies.first as? GetSearchGroupOperation,
              let data = getGroupOperation.data else { return }
        do {
            let groups = try JSONDecoder().decode(Groups.self, from: data)
            completion(groups.response.items)
        } catch let jsonError {
            print(jsonError)
        }
    }
}
