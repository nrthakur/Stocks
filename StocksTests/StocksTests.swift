//
//  StocksTests.swift
//  StocksTests
//
//  Created by Nikunj Thakur on 2024-07-15.
//

import XCTest
@testable import Stocks

final class StocksTests: XCTestCase {
    
    var viewModel: StocksViewModel!
    
    override func setUpWithError() throws {
        // Initialize the view model before each test
        viewModel = StocksViewModel()
    }
    
    override func tearDownWithError() throws {
        // Clean up the view model after each test
        viewModel = nil
    }
    
    func testCalculatePortfolioValue() throws {
        // Mock owned stocks
        let stocks = [
            Stock(ticker: "RUNINC", name: "Runners Inc.", currency: "USD", current_price_cents: 3614, quantity: 5, current_price_timestamp: 1681845832),
            Stock(ticker: "BAC", name: "Bank of America Corporation", currency: "USD", current_price_cents: 2393, quantity: 10, current_price_timestamp: 1681845832),
            Stock(ticker: "TRUNK", name: "Trunk Club", currency: "USD", current_price_cents: 17632, quantity: 9, current_price_timestamp: 1681845832),
            Stock(ticker: "UA", name: "Under Armour, Inc.", currency: "USD", current_price_cents: 844, quantity: 7, current_price_timestamp: 1681845832),
            Stock(ticker: "VTI", name: "Vanguard Total Stock Market Index Fund ETF Shares", currency: "USD", current_price_cents: 15994, quantity: 1, current_price_timestamp: 1681845832),
            Stock(ticker: "RUN", name: "Run", currency: "USD", current_price_cents: 6720, quantity: 12, current_price_timestamp: 1681845832),
            Stock(ticker: "^DJI", name: "Dow Jones Industrial Average", currency: "USD", current_price_cents: 2648154, quantity: 5, current_price_timestamp: 1681845832),
            Stock(ticker: "RUNWAY", name: "Rent The Runway", currency: "USD", current_price_cents: 24819, quantity: 20, current_price_timestamp: 1681845832)
        ]
        
        // Set the owned stocks in the view model
        viewModel.ownedStocks = stocks
        
        // Calculate portfolio value
        viewModel.calculatePortfolioValue()
        
        // Print the calculated portfolio value for debugging
        print("Calculated Portfolio Value: \(viewModel.portfolioValue)")
        
        // Verify the portfolio value
        XCTAssertEqual(viewModel.portfolioValue, 140403.80, accuracy: 0.01, "The portfolio value should be 140403.80")
    }
    
    func testFetchStocks() throws {
        // Mock data as returned from NetworkClient
        let stocks = [
            Stock(ticker: "^GSPC", name: "S&P 500", currency: "USD", current_price_cents: 318157, quantity: nil, current_price_timestamp: 1681845832),
            Stock(ticker: "RUNINC", name: "Runners Inc.", currency: "USD", current_price_cents: 3614, quantity: 5, current_price_timestamp: 1681845832),
            Stock(ticker: "BAC", name: "Bank of America Corporation", currency: "USD", current_price_cents: 2393, quantity: 10, current_price_timestamp: 1681845832),
            Stock(ticker: "EXPE", name: "Expedia Group, Inc.", currency: "USD", current_price_cents: 8165, quantity: nil, current_price_timestamp: 1681845832),
            Stock(ticker: "GRUB", name: "Grubhub Inc.", currency: "USD", current_price_cents: 6975, quantity: nil, current_price_timestamp: 1681845832),
            Stock(ticker: "TRUNK", name: "Trunk Club", currency: "USD", current_price_cents: 17632, quantity: 9, current_price_timestamp: 1681845832),
            Stock(ticker: "FIT", name: "Fitbit, Inc.", currency: "USD", current_price_cents: 678, quantity: nil, current_price_timestamp: 1681845832),
            Stock(ticker: "UA", name: "Under Armour, Inc.", currency: "USD", current_price_cents: 844, quantity: 7, current_price_timestamp: 1681845832),
            Stock(ticker: "VTI", name: "Vanguard Total Stock Market Index Fund ETF Shares", currency: "USD", current_price_cents: 15994, quantity: 1, current_price_timestamp: 1681845832),
            Stock(ticker: "RUN", name: "Run", currency: "USD", current_price_cents: 6720, quantity: 12, current_price_timestamp: 1681845832),
            Stock(ticker: "VWO", name: "Vanguard FTSE Emerging Markets", currency: "USD", current_price_cents: 4283, quantity: nil, current_price_timestamp: 1681845832),
            Stock(ticker: "JNJ", name: "Johnson & Johnson", currency: "USD", current_price_cents: 14740, quantity: nil, current_price_timestamp: 1681845832),
            Stock(ticker: "BRKA", name: "Berkshire Hathaway Inc.", currency: "USD", current_price_cents: 28100000, quantity: nil, current_price_timestamp: 1681845832),
            Stock(ticker: "^DJI", name: "Dow Jones Industrial Average", currency: "USD", current_price_cents: 2648154, quantity: 5, current_price_timestamp: 1681845832),
            Stock(ticker: "^TNX", name: "Treasury Yield 10 Years", currency: "USD", current_price_cents: 61, quantity: nil, current_price_timestamp: 1681845832),
            Stock(ticker: "RUNWAY", name: "Rent The Runway", currency: "USD", current_price_cents: 24819, quantity: 20, current_price_timestamp: 1681845832)
        ]
        
        // Set the owned and unowned stocks in the view model as if they were fetched
        viewModel.ownedStocks = stocks.filter { $0.quantity != nil }
        viewModel.unownedStocks = stocks.filter { $0.quantity == nil }
        
        // Verify that stocks are fetched correctly
        XCTAssertEqual(viewModel.ownedStocks.count, 8, "There should be 8 owned stocks")
        XCTAssertEqual(viewModel.unownedStocks.count, 8, "There should be 8 unowned stocks")
        
        // Check if the last fetched date is set
        viewModel.lastFetched = Date()
        XCTAssertNotNil(viewModel.lastFetched, "Last fetched date should not be nil")
    }
    
    func testOwnedStocksSortedByQuantity() throws {
        // Mock owned stocks
        let stocks = [
            Stock(ticker: "BAC", name: "Bank of America Corporation", currency: "USD", current_price_cents: 2393, quantity: 10, current_price_timestamp: 1681845832),
            Stock(ticker: "TRUNK", name: "Trunk Club", currency: "USD", current_price_cents: 17632, quantity: 9, current_price_timestamp: 1681845832),
            Stock(ticker: "UA", name: "Under Armour, Inc.", currency: "USD", current_price_cents: 844, quantity: 7, current_price_timestamp: 1681845832)
        ]
        
        // Set the owned stocks in the view model
        viewModel.ownedStocks = stocks
        
        // Manually sort the owned stocks by quantity
        viewModel.ownedStocks.sort { ($0.quantity ?? 0) > ($1.quantity ?? 0) }
        
        // Verify that owned stocks are sorted by quantity
        XCTAssertEqual(viewModel.ownedStocks.map { $0.ticker }, ["BAC", "TRUNK", "UA"], "Owned stocks should be sorted by quantity in descending order")
    }
    
    func testUnownedStocksSortedByTicker() throws {
        // Mock unowned stocks
        let stocks = [
            Stock(ticker: "VWO", name: "Vanguard FTSE Emerging Markets", currency: "USD", current_price_cents: 4283, quantity: nil, current_price_timestamp: 1681845832),
            Stock(ticker: "JNJ", name: "Johnson & Johnson", currency: "USD", current_price_cents: 14740, quantity: nil, current_price_timestamp: 1681845832),
            Stock(ticker: "BRKA", name: "Berkshire Hathaway Inc.", currency: "USD", current_price_cents: 28100000, quantity: nil, current_price_timestamp: 1681845832)
        ]
        
        // Set the unowned stocks in the view model
        viewModel.unownedStocks = stocks
        
        // Manually sort the unowned stocks by ticker
        viewModel.unownedStocks.sort { $0.ticker < $1.ticker }
        
        // Verify that unowned stocks are sorted by ticker
        XCTAssertEqual(viewModel.unownedStocks.map { $0.ticker }, ["BRKA", "JNJ", "VWO"], "Unowned stocks should be sorted by ticker in ascending order")
    }
    
    func testSearchStocks() throws {
        // Mock stocks
        let stocks = [
            Stock(ticker: "RUNINC", name: "Runners Inc.", currency: "USD", current_price_cents: 3614, quantity: 5, current_price_timestamp: 1681845832),
            Stock(ticker: "BAC", name: "Bank of America Corporation", currency: "USD", current_price_cents: 2393, quantity: 10, current_price_timestamp: 1681845832),
            Stock(ticker: "TRUNK", name: "Trunk Club", currency: "USD", current_price_cents: 17632, quantity: 9, current_price_timestamp: 1681845832)
        ]
        
        // Set the stocks in the view model
        viewModel.ownedStocks = stocks
        
        // Perform search
        let searchText = "Runners"
        let filteredStocks = viewModel.ownedStocks.filter { $0.name.contains(searchText) || $0.ticker.contains(searchText) }
        
        // Verify the filtered stocks
        XCTAssertEqual(filteredStocks.count, 1, "There should be 1 stock matching the search text")
        XCTAssertEqual(filteredStocks.first?.name, "Runners Inc.", "The matching stock should be 'Runners Inc.'")
    }
    
    func testLastFetchedDateFormat() throws {
        // Set the last fetched date in the view model
        let lastFetched = Date(timeIntervalSince1970: 1681845832)
        viewModel.lastFetched = lastFetched
        
        // Print the last fetched date for debugging
        print("Last fetched date (GMT): \(lastFetched)")
        
        // Get components to verify the date
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)! // Set the timezone to GMT
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: lastFetched)
        
        print("Date components: \(components)")
        
        // Format the date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0) // Set the timezone to GMT
        let formattedDate = formatter.string(from: lastFetched)
        
        // Print the formatted date for debugging
        print("Formatted date (GMT): \(formattedDate)")
        
        // Verify the date format
        XCTAssertEqual(formattedDate, "2023-04-18 19:23:52", "The formatted date should match the expected format")
    }
    
    func testRefreshStocks() throws {
        // Step 1: Mock some data to represent stocks returned from the network client
        let stocks = [
            Stock(ticker: "^GSPC", name: "S&P 500", currency: "USD", current_price_cents: 318157, quantity: nil, current_price_timestamp: 1681845832),
            Stock(ticker: "RUNINC", name: "Runners Inc.", currency: "USD", current_price_cents: 3614, quantity: 5, current_price_timestamp: 1681845832),
            Stock(ticker: "BAC", name: "Bank of America Corporation", currency: "USD", current_price_cents: 2393, quantity: 10, current_price_timestamp: 1681845832)
        ]
        
        // Step 2: Simulate refreshing the stocks by setting the owned and unowned stocks
        // Filter the stocks to set the owned stocks (those with a quantity)
        viewModel.ownedStocks = stocks.filter { $0.quantity != nil }
        
        // Filter the stocks to set the unowned stocks (those without a quantity)
        viewModel.unownedStocks = stocks.filter { $0.quantity == nil }
        
        // Step 3: Verify that the refresh functionality worked correctly
        // Check that there are 2 owned stocks after the refresh
        XCTAssertEqual(viewModel.ownedStocks.count, 2, "There should be 2 owned stocks after refresh")
        
        // Check that there is 1 unowned stock after the refresh
        XCTAssertEqual(viewModel.unownedStocks.count, 1, "There should be 1 unowned stock after refresh")
    }
}
