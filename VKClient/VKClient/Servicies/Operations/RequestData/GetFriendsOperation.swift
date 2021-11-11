//
//  GetFriendsOperation.swift
//  VKClient
//
//  Created by Pavel Olegovich on 07.11.2021.
//

import Foundation
import Alamofire

class GetFriendsOperation: AsyncOperation {
    
    private var request: DataRequest?
    var data: Data?
    var error: Error?
    
    override func main() {
        request = AF.request(UserRouter.getFriends).response(queue: DispatchQueue.global()) { [weak self] response in
            self?.data = response.data
            self?.error = response.error
            self?.state = .finished
        }
    }
    
    override func cancel() {
        request?.cancel()
        super.cancel()
    }
}
