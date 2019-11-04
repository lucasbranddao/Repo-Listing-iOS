//
//  ReposListViewController.swift
//  GitHub Test
//
//  Created by Lucas Brandão Pereira on 31/10/19.
//  Copyright (c) 2019 Lucas Brandão Pereira. All rights reserved.


import UIKit

protocol ReposListViewControllerContract: class {
    // func displaySomething()
}

class ReposListViewController: UIViewController, ReposListViewControllerContract {
    
    
//    let service = ReposListService()
    var dataSource = ReposListDataSource()
    lazy var viewModel = ReposListViewModel(dataSource: dataSource)
    
    @IBOutlet weak var filterPicker: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Initialization
    init() { super.init(nibName: "ReposListViewController", bundle: Bundle.main) }
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        tableView.delegate = self
        setupRefresh()
        
        tableView.register(UINib(nibName: "RepoisListTableViewCell", bundle: .main), forCellReuseIdentifier: "RepoisListTableViewCell")
        filterPicker.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)

        addObservers()
        viewModel.fetchRepositories(isRefresh: false)
        
       
    }
    
    func addObservers(){
        dataSource.data.addObserver(self, completionHandler: {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
        viewModel.isLoading.addAndNotify(observer: self, completionHandler:{
            if self.viewModel.isLoading.value{
                self.showLoading()
            }
            else{
                self.dismiss(animated: false, completion: nil)
            }
        })
    }
    
    func setupRefresh(){
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
    }
    
    @objc func refresh(refreshControl: UIRefreshControl) {
        
        viewModel.refresh()
        refreshControl.endRefreshing()
    }
    
    func showLoading(){
        let alert = UIAlertController(title: nil, message: "Carregando", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.color = UIColor.gray
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        if dataSource.data.value.isEmpty{
            return
        }
        
        switch sender.selectedSegmentIndex {
        case 0:
            self.viewModel.sortData(by: .followers)
        case 1:
            self.viewModel.sortData(by: .forks)
        case 2:
            self.viewModel.sortData(by: .stars)

        default:
            break
        }
    }
    
}



extension ReposListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            if ((indexPath.section == tableView.numberOfSections - 1) &&
                (indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1)) {
                
                if !self.viewModel.isLoading.value{
                    self.viewModel.fetchRepositories(isRefresh: false)
                }
                

            }
        }
}

