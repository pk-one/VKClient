//
//  ParsePhotosUserOperation.swift
//  VKClient
//
//  Created by Pavel Olegovich on 07.11.2021.
//

import Foundation
import SwiftyJSON

class ParsePhotosUserOperation: Operation {
    
    private let completion: ([Photos]) -> Void
    
    init(completion: @escaping ([Photos]) -> Void) {
        self.completion = completion
    }
    
    override func main() {
        guard let getPhotosUserOperation = dependencies.first as? GetPhotosUserOperation,
              let data = getPhotosUserOperation.data else { return }
        let json = JSON(data)
        let photosItems = json["response"]["items"].arrayValue
        let photos = photosItems.map { Photos($0) }
            completion(photos)
    }
}
