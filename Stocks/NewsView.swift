//
//  NewsView.swift
//  Stocks
//
//  Created by Nikunj Thakur on 2024-07-10.
//

import WebKit
import SwiftUI
import SafariServices

// Custom wrapper to make URL Identifiable
struct IdentifiableURL: Identifiable {
    let id = UUID()
    let url: URL
}

struct NewsView: View {
    @State private var selectedURL: IdentifiableURL?
    
    var body: some View {
        List {
            // Navigation link to Bloomberg
            Button("Bloomberg") {
                selectedURL = IdentifiableURL(url: URL(string: "https://www.bloomberg.com/canada")!)
            }
            .buttonStyle(PlainButtonStyle())

            // Navigation link to Yahoo Finance
            Button("Yahoo Finance") {
                selectedURL = IdentifiableURL(url: URL(string: "https://ca.finance.yahoo.com")!)
            }
            .buttonStyle(PlainButtonStyle())

            // Navigation link to CNBC
            Button("CNBC") {
                selectedURL = IdentifiableURL(url: URL(string: "https://www.cnbc.com")!)
            }
            .buttonStyle(PlainButtonStyle())

            // Navigation link to Forbes
            Button("Forbes") {
                selectedURL = IdentifiableURL(url: URL(string: "https://www.forbes.com")!)
            }
            .buttonStyle(PlainButtonStyle())

            // Navigation link to BBC
            Button("BBC") {
                selectedURL = IdentifiableURL(url: URL(string: "https://www.bbc.co.uk/programmes/p002vsxs")!)
            }
            .buttonStyle(PlainButtonStyle())

            // Navigation link to MarketWatch
            Button("MarketWatch") {
                selectedURL = IdentifiableURL(url: URL(string: "https://www.marketwatch.com")!)
            }
            .buttonStyle(PlainButtonStyle())

            // Navigation link to CBC
            Button("CBC") {
                selectedURL = IdentifiableURL(url: URL(string: "https://www.cbc.ca/news/business")!)
            }
            .buttonStyle(PlainButtonStyle())

            // Navigation link to Business Insider
            Button("Business Insider") {
                selectedURL = IdentifiableURL(url: URL(string: "https://www.businessinsider.com")!)
            }
            .buttonStyle(PlainButtonStyle())

            // Navigation link to theScore
            Button("theScore") {
                selectedURL = IdentifiableURL(url: URL(string: "https://www.thescore.com")!)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .navigationTitle("News") // Title for the navigation bar
        .fullScreenCover(item: $selectedURL) { identifiableURL in
            SafariView(url: identifiableURL.url)
        }
    }
}

#Preview {
    NewsView()
}
