//
//  SettingsView.swift
//  Stocks
//
//  Created by Nikunj Thakur on 2024-07-10.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            // Navigation link to the Help page
            NavigationLink(destination: Text("For questions, reach out to whatsupbrother@thescore.com")) {
                Text("Help")
            }

            // Navigation link to the About page
            NavigationLink(destination: Text("This one is for Jake, Angie, and Roman.")) {
                Text("About")
            }

            // Navigation link to the Privacy Policy page
            NavigationLink(destination: Text("What Privacy lol")) {
                Text("Privacy Policy")
            }
        }
        .navigationTitle("Settings") // Title for the navigation bar
    }
}

#Preview {
    SettingsView()
}
