//
//  RonSwansonQuotesNet.swift
//  GitHub
//
//  Created by Tim Lemaster on 3/7/18.
//  Copyright © 2018 LeMaster Design Lab. All rights reserved.
//

import Foundation

enum RonSwansonError: Error {
    case badRequest
    case noData
    case malformedData
    case underlaying(error: Error)
}

protocol RonSwansonQuotesNet {
    
    func getQuotes(_ count: Int, completion: @escaping (RonSwansonReply) -> ())
}
