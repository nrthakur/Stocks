//
//  StocksViewModel.swift
//  Stocks
//
//  Created by Nikunj Thakur on 2024-07-10.
//

import Foundation
import Combine

class StocksViewModel: ObservableObject {
    // Published properties to store owned and unowned stocks and the last fetched date
    @Published var ownedStocks: [Stock] = []
    @Published var unownedStocks: [Stock] = []
    @Published var lastFetched: Date?
    @Published var portfolioValue: Double = 0.0 // Published property for portfolio value
    
    // Set to hold any cancellable references
    private var cancellables = Set<AnyCancellable>()
    
    // Method to fetch stocks
    func fetchStocks() {
        NetworkClient.shared.fetchStocks()
            .receive(on: DispatchQueue.main) // Ensure the following operations are performed on the main thread
            .sink(receiveCompletion: { completion in
                // Handle completion of the publisher
                switch completion {
                case .failure(let error):
                    // Print error if the fetch fails
                    print("Failed to fetch stocks: \(error)")
                case .finished:
                    // No action needed on successful completion
                    break
                }
            }, receiveValue: { [weak self] stocks in
                // Log the fetched stocks to the console
                print("Fetched Stocks: \(stocks)")
                
                // Process the fetched stocks data
                // Filter and sort owned stocks
                self?.ownedStocks = stocks.filter { ($0.quantity ?? 0) > 0 }
                                          .sorted { ($0.quantity ?? 0) > ($1.quantity ?? 0) }
                
                // Filter and sort unowned stocks
                self?.unownedStocks = stocks.filter { ($0.quantity ?? 0) == 0 }
                                            .sorted { $0.ticker < $1.ticker }
                
                // Update the last fetched date
                self?.lastFetched = Date()
                
                // Calculate the portfolio value
                self?.calculatePortfolioValue()
            })
            .store(in: &cancellables) // Store the cancellable reference to manage memory
    }
    
    // Function to calculate portfolio value
    private func calculatePortfolioValue() {
        portfolioValue = ownedStocks.reduce(0.0) { $0 + Double($1.quantity ?? 0) * Double($1.current_price_cents) / 100.0 }
    }
}
