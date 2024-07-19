//
//  NetworkClient.swift
//  Stocks
//
//  Created by Nikunj Thakur on 2024-07-10.
//

import Foundation
import Combine

class NetworkClient {
    // Shared singleton instance of NetworkClient
    static let shared = NetworkClient()
    
    // URL string for fetching stock data
    private let urlString = "https://storage.googleapis.com/cash-homework/cash-stocks-api/portfolio.json"
    
    // Cache to store fetched stock data
    private var cache: [Stock]?
    
    // Method to fetch stocks
    func fetchStocks() -> AnyPublisher<[Stock], Error> {
        // Return cached stocks if available
        if let cachedStocks = cache {
            return Just(cachedStocks)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        // Ensure the URL is valid
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        // Fetch data from the URL
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data) // Extract data from the response
            .decode(type: Portfolio.self, decoder: JSONDecoder()) // Decode data into Portfolio object
            .map(\.stocks) // Extract stocks from the Portfolio
            .handleEvents(receiveOutput: { [weak self] stocks in
                // Cache the fetched stocks
                self?.cache = stocks
            })
            .eraseToAnyPublisher()
    }
    
    // Method to clear the cache
    func clearCache() {
        cache = nil
    }
}





