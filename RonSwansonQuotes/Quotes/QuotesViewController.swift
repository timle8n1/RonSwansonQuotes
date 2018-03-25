//
//  QuotesViewController.swift
//  GitHub
//
//  Created by Tim Lemaster on 3/8/18.
//  Copyright © 2018 LeMaster Design Lab. All rights reserved.
//

import UIKit

class QuotesViewController: UIViewController, ServiceInjected {
    
    private var quotesView: QuotesView? {
        guard isViewLoaded else { return nil }
        
        return view as? QuotesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quotesView?.refreshQuotesHandler = { [weak self] in
            self?.getQuotes()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getQuotes()
    }
    
    private func getQuotes() {
        quotesView?.isLoadingQuotes = true
        ronSwansonQuotesService.getQuotes { (quotes) in
            DispatchQueue.main.async { [weak self] in
                
                self?.quotesView?.isLoadingQuotes = false
                self?.quotesView?.quotesViewModel = QuotesViewModel(quotes: quotes)
            }
        }
    }
}
