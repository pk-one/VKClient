//
//  GetPhotosUserOperation.swift
//  VKClient
//
//  Created by Pavel Olegovich on 07.11.2021.
//

import Foundation
import Alamofire

class GetPhotosUserOperation: AsyncOperation {
    
    private var request: DataRequest?
    private var ownerId: Int?
    
    var data: Data?
    var error: Error?
    
    init(ownerId: Int) {
        self.ownerId = ownerId
    }
    
    override func main() {
        request = AF.request(UserRouter.getPhotosFriends(ownerId: ownerId!)).response(queue: DispatchQueue.global()) { [weak self] response in
            guard let self = self else { return }
            self.data = response.data
            self.error = response.error
            self.state = .finished
        }
    }
    override func cancel() {
        request?.cancel()
        super.cancel()
    }
}
