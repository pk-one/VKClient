//
//  GetSearchGroupOperation.swift
//  VKClient
//
//  Created by Pavel Olegovich on 07.11.2021.
//

import Foundation
import Alamofire

class GetSearchGroupOperation: AsyncOperation {
    
    private var request: DataRequest?
    private var textSearch: String?
    
    var data: Data?
    var error: Error?
    
    init(textSearch: String) {
        self.textSearch = textSearch
    }
    
    override func main() {
        guard let textSearch = textSearch else { return }
        request = AF.request(GroupRouter.searchGroup(textSearch: textSearch)).response(queue: DispatchQueue.global()) { [weak self] response in
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
