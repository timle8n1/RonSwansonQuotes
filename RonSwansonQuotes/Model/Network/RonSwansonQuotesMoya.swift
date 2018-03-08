//
//  RonSwansonQuotesMoya.swift
//  GitHub
//
//  Created by Tim Lemaster on 3/8/18.
//  Copyright © 2018 LeMaster Design Lab. All rights reserved.
//

import Foundation
import Moya

class RonSwansonQuotesMoya: RonSwansonQuotesNet {
    
    private let provider = MoyaProvider<RonSwansonTarget>()
    
    func getQuotes(_ count: Int, completion: @escaping (RonSwansonReply) -> ()) {
        
        provider.request(.getQuotes(count: count),
                         callbackQueue: DispatchQueue.global(qos: .utility),
                         progress: nil) { result in
            switch result {
            case let .success(response):
                
                do {
                    let quotes = try JSONDecoder().decode([String].self, from: response.data)
                    completion(RonSwansonReply(quotes: quotes, error: nil))
                } catch let error {
                    completion(RonSwansonReply(quotes: nil, error: .underlaying(error: error)))
                }
                
            case let .failure(error):
                completion(RonSwansonReply(quotes: nil, error: .underlaying(error: error)))
            }
            
        }
    }
}

enum RonSwansonTarget {
    case getQuotes(count: Int)
}

extension RonSwansonTarget: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://ron-swanson-quotes.herokuapp.com/v2")!
    }
    
    var path: String {
        switch self {
        case .getQuotes(let count):
            return "/quotes/\(count)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var sampleData: Data {
        return "[\"The key to burning an ex-wife effigy is to dip it in paraffin wax and then toss the flaming bottle of isopropyl alcohol from a safe distance. Do not stand too close when you light an ex-wife effigy.\"]".data(using: .utf8)!
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
