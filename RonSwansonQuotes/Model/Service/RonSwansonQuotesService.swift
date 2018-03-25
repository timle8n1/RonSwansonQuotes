//
//  RonSwansonQuotesService.swift
//  RonSwansonQuotes
//
//  Created by Tim Lemaster on 3/25/18.
//  Copyright © 2018 LeMaster Design Lab. All rights reserved.
//

import Foundation

typealias QuotesUpdatedHandler = ([String]) -> Void

protocol RonSwansonQuotesService {
    
    func getQuotes(completion: @escaping QuotesUpdatedHandler)
}

class RonSwansonQuotesFromNetwork: RonSwansonQuotesService, NetInjected {
    
    func getQuotes(completion: @escaping QuotesUpdatedHandler) {
        ronSwansonQuotesNet.getQuotes(20) { (reply) in
            
            if let q = reply.quotes {
                completion(q)
            } else {
                completion([String]())
            }
        }
    }
}
