//
//  RepositoriesRequest.swift
//  GitHub API's Test
//
//  Created by Lucas Brandão Pereira on 01/11/19.
//  Copyright © 2019 Lucas Brandão Pereira. All rights reserved.
//

import Foundation

class RepositoriesRequest: Request {
    var count: Int
    
    init(count: Int){
        self.count = count
    }
    
    var endpoint: String{
        return "https://api.github.com/search/repositories?q=dog&page=1&per_page=\(self.count)"
    }
    var method: HTTPMethod = .get
     
  
}
