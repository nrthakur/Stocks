//
//  ContentView.swift
//  Stocks
//
//  Created by Nikunj Thakur on 2024-07-10.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = StocksViewModel() // ObservedObject to observe changes in StocksViewModel
    
    @State private var searchText = "" // State variable to store search text
    
    var body: some View {
        NavigationView {
            VStack {
                // Display portfolio value
                Text("Portfolio Value: $\(viewModel.portfolioValue, specifier: "%.2f")")
                    .font(.title)
                    .foregroundColor(.green) // Set the text color to green
                    .padding()
                
                // Real-time clock view
                RealTimeClockView()
                    .padding(.bottom, 10) // Add some padding to separate from the search bar
                
                // Searchable list of stocks
                List {
                    // Section for owned stocks with a custom header
                    Section(header: HeaderView(title: "Owned Stocks", lastFetched: viewModel.lastFetched)) {
                        ForEach(filteredOwnedStocks) { stock in
                            StockRow(stock: stock) // Row for each owned stock
                        }
                    }
                    
                    // Section for unowned stocks with a custom header
                    Section(header: HeaderView(title: "Unowned Stocks", lastFetched: viewModel.lastFetched)) {
                        ForEach(filteredUnownedStocks) { stock in
                            StockRow(stock: stock) // Row for each unowned stock
                        }
                    }
                }
                .searchable(text: $searchText, prompt: "Search stocks") // Search bar for filtering stocks
            }
            .navigationTitle("Stocks") // Title for the navigation bar
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    // Refresh button to fetch stocks
                    Button("Refresh") {
                        viewModel.fetchStocks()
                    }
                    
                    // Navigation link to the settings page
                    NavigationLink(destination: NewsView()) {
                        Image(systemName: "newspaper") // Settings icon
                    }
                    
                    // Navigation link to the news page
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear") // News icon
                    }
                }
            }
            .onAppear {
                viewModel.fetchStocks() // Fetch stocks when the view appears
            }
        }
    }
    
    // Computed property to filter owned stocks based on search text
    private var filteredOwnedStocks: [Stock] {
        if searchText.isEmpty {
            return viewModel.ownedStocks
        } else {
            return viewModel.ownedStocks.filter { $0.name.contains(searchText) || $0.ticker.contains(searchText) }
        }
    }
    
    // Computed property to filter unowned stocks based on search text
    private var filteredUnownedStocks: [Stock] {
        if searchText.isEmpty {
            return viewModel.unownedStocks
        } else {
            return viewModel.unownedStocks.filter { $0.name.contains(searchText) || $0.ticker.contains(searchText) }
        }
    }
}

struct StockRow: View {
    let stock: Stock // Stock object for the row
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(stock.name) (\(stock.ticker))") // Stock name and ticker
                .font(.headline)
            Text("Quantity: \(stock.quantity ?? 0), Price: \(Double(stock.current_price_cents) / 100.0, specifier: "%.2f")") // Stock quantity and price
                .font(.subheadline)
        }
    }
}

struct HeaderView: View {
    let title: String // Title for the header
    let lastFetched: Date? // Last fetched date for the header
    
    var body: some View {
        HStack {
            Text(title) // Header title
                .font(.headline)
            Spacer()
            if let lastFetched = lastFetched {
                Text("Last fetched: \(formattedDate(lastFetched))") // Last fetched date
                    .font(.footnote)
            }
        }
    }
    
    // Function to format the date
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date)
    }
}

#Preview {
    ContentView()
}
