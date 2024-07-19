//
//  stockone.swift
//  Stocks
//
//  Created by Nikunj Thakur on 2024-07-10.
//

import Foundation

struct Stock: Codable, Identifiable {
    let id = UUID()
    let ticker: String
    let name: String
    let currency: String
    let current_price_cents: Int
    let quantity: Int?
    let current_price_timestamp: Int
}
