//
//  ParsePhotosUserOperation.swift
//  VKClient
//
//  Created by Pavel Olegovich on 07.11.2021.
//

import Foundation
import SwiftyJSON

class ParsePhotosUserOperation: Operation {
    
    private let completion: ([PhotosItems]) -> Void
    
    init(completion: @escaping ([PhotosItems]) -> Void) {
        self.completion = completion
    }
    
    override func main() {
        guard let getPhotosUserOperation = dependencies.first as? GetPhotosUserOperation,
              let data = getPhotosUserOperation.data else { return }
        
        do {
            let photos = try JSONDecoder().decode(Photos.self, from: data)
            completion(photos.response.items)
        } catch let jsonError {
            print(jsonError)
        }
    }
}
