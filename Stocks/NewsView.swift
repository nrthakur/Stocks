//
//  NewsView.swift
//  Stocks
//
//  Created by Nikunj Thakur on 2024-07-10.
//

import SwiftUI
import SafariServices

struct NewsView: View {
    var body: some View {
        List {
            // Navigation link to Bloomberg
            NavigationLink(destination: SafariView(url: URL(string: "https://www.bloomberg.com/canada")!)) {
                Text("Bloomberg")
            }

            // Navigation link to Yahoo Finance
            NavigationLink(destination: SafariView(url: URL(string: "https://ca.finance.yahoo.com")!)) {
                Text("Yahoo Finance")
            }

            // Navigation link to CNBC
            NavigationLink(destination: SafariView(url: URL(string: "https://www.cnbc.com")!)) {
                Text("CNBC")
            }
            
            // Navigation link to CNBC
            NavigationLink(destination: SafariView(url: URL(string: "https://www.forbes.com")!)) {
                Text("Forbes")
            }
            
            // Navigation link to CNBC
            NavigationLink(destination: SafariView(url: URL(string: "https://www.bbc.co.uk/programmes/p002vsxs")!)) {
                Text("BBC")
            }
            
            // Navigation link to CNBC
            NavigationLink(destination: SafariView(url: URL(string: "https://www.marketwatch.com")!)) {
                Text("MarketWatch")
            }
            
            // Navigation link to CNBC
            NavigationLink(destination: SafariView(url: URL(string: "https://www.cbc.ca/news/business")!)) {
                Text("CBC")
            }
            
            // Navigation link to CNBC
            NavigationLink(destination: SafariView(url: URL(string: "https://www.businessinsider.com")!)) {
                Text("Business Insider")
            }
            
            // Navigation link to CNBC
            NavigationLink(destination: SafariView(url: URL(string: "https://www.thescore.com")!)) {
                Text("theScore ;)")
            }
        }
        .navigationTitle("News") // Title for the navigation bar
    }
}

#Preview {
    NewsView()
}

