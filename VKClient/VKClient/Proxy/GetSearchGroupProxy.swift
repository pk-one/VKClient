//
//  GetSearchGroupProxy.swift
//  VKClient
//
//  Created by Pavel Olegovich on 19.02.2022.
//

import Foundation

class GetSearchGroupProxy: GetSearchGroupProtocol {
    
    let service: GetSearchGroupProtocol
    
    init(service: GetSearchGroupProtocol) {
        self.service = service
    }
    
    func getGroupSearch(textSearch: String, handler: @escaping ([GroupsItems]) -> Void) {
        service.getGroupSearch(textSearch: textSearch) { groupsSearch in
            print("Get search groups")
            handler(groupsSearch)
        }
    }
}
