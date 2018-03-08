//
//  RonSwansonQuotesURLSession.swift
//  GitHub
//
//  Created by Tim Lemaster on 3/8/18.
//  Copyright © 2018 LeMaster Design Lab. All rights reserved.
//

import Foundation

class RonSwansonQuotesURLSession: RonSwansonQuotesNet {
    
    func getQuotes(_ count: Int, completion: @escaping (RonSwansonReply) -> ()) {
        
        if let url = URL(string: "https://ron-swanson-quotes.herokuapp.com/v2/quotes/\(count)") {
            let urlSession = URLSession.shared
            let task = urlSession.dataTask(with: url, completionHandler: { (data, response, error) in
                if let error = error {
                    completion(RonSwansonReply(quotes: nil, error: .underlaying(error: error)))
                    return
                }
                
                guard let data = data else {
                    completion(RonSwansonReply(quotes: nil, error: .noData))
                    return
                }
                
                do {
                    let quotes = try JSONDecoder().decode([String].self, from: data)
                    completion(RonSwansonReply(quotes: quotes, error: nil))
                } catch let error {
                    completion(RonSwansonReply(quotes: nil, error: .underlaying(error: error)))
                }
            })
            task.resume()
        } else {
            completion(RonSwansonReply(quotes: nil, error: .badRequest))
        }
    }
}
