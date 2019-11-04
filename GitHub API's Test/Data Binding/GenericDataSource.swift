//
//  GenericDataSource.swift
//  GitHub API's Test
//
//  Created by Lucas Brandão Pereira on 01/11/19.
//  Copyright © 2019 Lucas Brandão Pereira. All rights reserved.
//

import Foundation

class GenericDataSource<T> : NSObject {
    var data: Observable<[T]> = Observable([])
}
