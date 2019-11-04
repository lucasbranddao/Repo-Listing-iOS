//
//  RepositoriesService.swift
//  GitHub API's Test
//
//  Created by Lucas Brandão Pereira on 01/11/19.
//  Copyright © 2019 Lucas Brandão Pereira. All rights reserved.
//

import Foundation

protocol RepositoriesServiceProtocol: class {
    func getRepositories( count: Int, completion: @escaping(_ response: RespositoriesResponse?, _ errorMessage: String?) -> Void)
}

class RepositoriesService: RepositoriesServiceProtocol {
    func getRepositories(count: Int, completion: @escaping(_ response: RespositoriesResponse?, _ errorMessage: String?) -> Void) {
        let request = RepositoriesRequest(count: count)
        Remote.makeRequest(request: request, completionHandler: completion)
    }
}
