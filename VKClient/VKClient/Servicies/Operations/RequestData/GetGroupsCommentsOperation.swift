//
//  GetGroupsCommentsOperation.swift
//  VKClient
//
//  Created by Pavel Olegovich on 11.11.2021.
//

import Foundation
import Alamofire

class GetGroupsCommentsOperation: AsyncOperation {
    
    private var request: DataRequest?
    private var ownerId: Int?
    private var postId: Int?
    
    var data:Data?
    var error: Error?
    
    init(ownerId: Int, postId: Int) {
        self.ownerId = ownerId
        self.postId = postId
    }
    
    override func main() {
        guard let ownerId = ownerId, let postId = postId else { return }
        request = AF.request(NewsRouter.getCommentsGroups(ownerId: ownerId, postId: postId))
            .response(queue: DispatchQueue.global()) { [weak self] response in
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
