//
//  SafariView.swift
//  Stocks
//
//  Created by Nikunj Thakur on 2024-07-10.
//

import SwiftUI
import SafariServices

// A SwiftUI view that wraps an SFSafariViewController
struct SafariView: UIViewControllerRepresentable {
    let url: URL // The URL to be displayed in the Safari view

    // Creates and returns an SFSafariViewController instance
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        let safariViewController = SFSafariViewController(url: url)
        return safariViewController
    }

    // Updates the SFSafariViewController instance
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
    }
}

// Preview provider for testing the SafariView with a sample URL
#Preview {
    SafariView(url: URL(string: "https://www.thescore.com")!)
}
