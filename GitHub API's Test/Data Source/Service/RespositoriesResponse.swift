//
//  RespositoriesResponse.swift
//  GitHub API's Test
//
//  Created by Lucas Brandão Pereira on 01/11/19.
//  Copyright © 2019 Lucas Brandão Pereira. All rights reserved.
//

import Foundation

struct RespositoriesResponse: Codable {
    let items: [Item]
    
    struct Item: Codable {
        let name: String?
        let stargazers_count: Int?
        let watchers_count: Int?
        let forks_count: Int?

        let owner: Owner
        
        struct Owner: Codable {
            let login: String?
            let avatar_url: String?
        }
    }
}
