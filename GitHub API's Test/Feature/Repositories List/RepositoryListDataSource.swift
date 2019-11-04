//
//  RepositoryListDataSource.swift
//  GitHub API's Test
//
//  Created by Lucas Brandão Pereira on 03/11/19.
//  Copyright © 2019 Lucas Brandão Pereira. All rights reserved.
//

import UIKit
import Kingfisher

class ReposListDataSource: GenericDataSource<RepositoryModel>, UITableViewDataSource{
    
    var selectedCell = Observable<Int?>(nil)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoisListTableViewCell", for: indexPath) as! RepoisListTableViewCell
        let item = data.value[indexPath.row]

        cell.selectionStyle = .none
        cell.nameLabel.text = item.name
        cell.userLabel.text = "by: \(item.user)"
        cell.starsLabel.text = "\(item.stars) Stars"
        cell.forksLabel.text = "\(item.forks) Forks"
        cell.followersLabel.text = "\(item.followers) Followers"

        
        if let url = URL(string: item.image) {
            cell.iconImageView.kf.setImage(with: url)
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
}
