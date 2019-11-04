//
//  ReposListViewModel.swift
//  GitHub Test
//
//  Created by Lucas Brandão Pereira on 31/10/19.
//  Copyright (c) 2019 Lucas Brandão Pereira. All rights reserved.
//

import UIKit

enum SortType{
    case stars
    case followers
    case forks
}

protocol ReposListViewModelContract {
    func fetchRepositories(isRefresh: Bool)
    func refresh()
    func sortData(by: SortType)
}

class ReposListViewModel: ReposListViewModelContract {
    
    var service = RepositoriesService()
    weak var dataSource: ReposListDataSource?
    var repositories = Observable<[RepositoryModel]>([])
    var isLoading = Observable<Bool>(false)
    var current = SortType.followers
    var count = 0
    
    init(dataSource: ReposListDataSource) {
        self.dataSource = dataSource
    }
    
    
    func fetchRepositories(isRefresh: Bool) {
        if !isRefresh{
            self.isLoading.value = true
        }
        
        service.getRepositories(count: self.count, completion: { response, error in
            if !isRefresh{
                self.isLoading.value = false
                self.count += isRefresh ? 0 : 30
            }
            guard let resp = response else{
                //handle error
                return
            }
            
            self.dataSource?.data.value = resp.items.compactMap({ RepositoryModel(name: $0.name ?? "Nome Indisponível", user: $0.owner.login ?? "", image: $0.owner.avatar_url ?? "", stars: $0.stargazers_count ?? 0, followers: $0.watchers_count ?? 0, forks: $0.forks_count ?? 0) })
            self.sortData(by: self.current)
        })
    }
    
    func refresh() {
        self.fetchRepositories(isRefresh: true)
    }
    
    func sortData(by: SortType) {
        
        var sorted: [RepositoryModel] = []
        self.current = by
        
        switch current {
        case .followers:
            sorted = self.dataSource?.data.value.sorted(by:  { $0.followers > $1.followers }) ?? []
        case .stars:
            sorted = self.dataSource?.data.value.sorted(by:  { $0.stars > $1.stars }) ?? []
        case .forks:
            sorted = self.dataSource?.data.value.sorted(by:  { $0.forks > $1.forks}) ?? []
        }
        self.dataSource?.data.value = sorted
    }
   
}
