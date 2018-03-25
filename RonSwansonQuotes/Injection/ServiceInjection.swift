//
//  ServiceInjection.swift
//  RonSwansonQuotes
//
//  Created by Tim Lemaster on 3/25/18.
//  Copyright © 2018 LeMaster Design Lab. All rights reserved.
//

import Foundation

protocol ServiceInjected { }

struct ServiceInjector {
    static var ronSwansonQuotesService: RonSwansonQuotesService = RonSwansonQuotesFromNetwork()
}

extension ServiceInjected {
    var ronSwansonQuotesService: RonSwansonQuotesService { return ServiceInjector.ronSwansonQuotesService }
}
