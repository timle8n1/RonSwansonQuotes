//
//  QuotesViewController.swift
//  GitHub
//
//  Created by Tim Lemaster on 3/8/18.
//  Copyright © 2018 LeMaster Design Lab. All rights reserved.
//

import UIKit

class QuotesViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    private let refreshControl = UIRefreshControl()
    private let viewModel = QuotesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshQuotes(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.137, green:0.341, blue:0.537, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Ron Swanson Quotes ...")
        
        viewModel.quotesUpdatedHandler = {
            DispatchQueue.main.async { [weak self] in
                
                guard let strongSelf = self else { return }
                    
                strongSelf.tableView.reloadData()
                strongSelf.refreshControl.endRefreshing()
                strongSelf.activityIndicator.stopAnimating()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getQuotes()
    }
    
    @objc
    private func refreshQuotes(_ sender: Any) {
        getQuotes()
    }
    
    private func getQuotes() {
        
        if !refreshControl.isRefreshing {
            refreshControl.beginRefreshing()
        }
        activityIndicator.startAnimating()
        
        viewModel.getQuotes()
    }
}

extension QuotesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath)
        
        guard indexPath.row < viewModel.quotes.count else {
            cell.textLabel?.text = "Unknown"
            return cell
            
        }
        
        let quote = viewModel.quotes[indexPath.row]
        cell.textLabel?.text = quote
        
        return cell
    }
}
