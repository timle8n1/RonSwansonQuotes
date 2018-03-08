//
//  QuotesViewModel.swift
//  GitHub
//
//  Created by Tim Lemaster on 3/8/18.
//  Copyright © 2018 LeMaster Design Lab. All rights reserved.
//

import Foundation

typealias QuotesUpdatedHandler = () -> Void

class QuotesViewModel: NetInjected {
    
    var quotesUpdatedHandler: QuotesUpdatedHandler?
    
    private(set) var quotes = [String]() {
        didSet {
            quotesUpdatedHandler?()
        }
    }
    
    func getQuotes() {
        ronSwansonQuotesNet.getQuotes(20) { [weak self] (reply) in
            
            if let q = reply.quotes {
                self?.quotes = q
            }
        }
    }
}
