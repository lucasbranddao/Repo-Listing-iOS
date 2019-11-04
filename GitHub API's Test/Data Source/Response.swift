//
//  Response.swift
//  GitHub API's Test
//
//  Created by Lucas Brandão Pereira on 31/10/19.
//  Copyright © 2019 Lucas Brandão Pereira. All rights reserved.
//

import Foundation



struct Response {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
}
