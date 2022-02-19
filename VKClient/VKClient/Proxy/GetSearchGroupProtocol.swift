//
//  GetSearchGroupProtocol.swift
//  VKClient
//
//  Created by Pavel Olegovich on 19.02.2022.
//

import Foundation

protocol GetSearchGroupProtocol {
    
    func getGroupSearch(textSearch: String, handler: @escaping ([GroupsItems]) -> Void)
}
