//
//  QuotesView.swift
//  RonSwansonQuotes
//
//  Created by Tim Lemaster on 3/25/18.
//  Copyright © 2018 LeMaster Design Lab. All rights reserved.
//

import UIKit

typealias RefreshQuotesHandler = () -> Void

struct QuotesViewModel {
    let quotes: [String]
}

class QuotesView: UIView {
    
    var refreshQuotesHandler: RefreshQuotesHandler?
    
    var quotesViewModel = QuotesViewModel(quotes: [String]()) {
        didSet {
            tableView.reloadData()
        }
    }
    
    var isLoadingQuotes = false {
        didSet {
            if isLoadingQuotes {
                if !refreshControl.isRefreshing {
                    refreshControl.beginRefreshing()
                }
                activityIndicator.startAnimating()
            } else {
                refreshControl.endRefreshing()
                activityIndicator.stopAnimating()
            }
        }
    }
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    private let refreshControl = UIRefreshControl()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshQuotes(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.137, green:0.341, blue:0.537, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Ron Swanson Quotes ...")
    }
    
    @objc
    private func refreshQuotes(_ sender: Any) {
        refreshQuotesHandler?()
    }
}

extension QuotesView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotesViewModel.quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath)
        
        guard indexPath.row < quotesViewModel.quotes.count else {
            cell.textLabel?.text = "Unknown"
            return cell
            
        }
        
        let quote = quotesViewModel.quotes[indexPath.row]
        cell.textLabel?.text = quote
        
        return cell
    }
}
