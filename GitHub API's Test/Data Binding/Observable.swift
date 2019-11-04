//
//  Observable.swift
//  GitHub API's Test
//
//  Created by Lucas Brandão Pereira on 01/11/19.
//  Copyright © 2019 Lucas Brandão Pereira. All rights reserved.
//

import Foundation

typealias CompletionHandler = (() -> Void)

class Observable<T> {
    private var observers = [String: CompletionHandler]()
    
    var value : T {
        didSet {
            self.notify()
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    public func addObserver(_ observer: NSObject, completionHandler: @escaping CompletionHandler) {
        observers[observer.description] = completionHandler
    }
    
    public func addAndNotify(observer: NSObject, completionHandler: @escaping CompletionHandler) {
        self.addObserver(observer, completionHandler: completionHandler)
        self.notify()
    }
    
    private func notify() {
        observers.forEach { $0.value() }
    }
    
    deinit {
        observers.removeAll()
    }
}
