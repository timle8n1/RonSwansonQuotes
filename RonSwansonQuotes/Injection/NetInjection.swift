//
//  NetInjection.swift
//  GitHub
//
//  Created by Tim Lemaster on 3/8/18.
//  Copyright © 2018 LeMaster Design Lab. All rights reserved.
//

import Foundation

protocol NetInjected { }

struct NetInjector {
    static var ronSwansonQuotesNet: RonSwansonQuotesNet = RonSwansonQuotesURLSession()
}

extension NetInjected {
    var ronSwansonQuotesNet: RonSwansonQuotesNet { return NetInjector.ronSwansonQuotesNet }
}
