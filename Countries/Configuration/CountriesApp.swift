//
//  CountriesApp.swift
//  Countries
//
//  Created by Denis Denisov on 24/12/24.
//

import SwiftUI
import SwiftData

@main
struct CountriesApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                CountriesListView()
                    .environment(\.screenSize, UIScreen.main.bounds.size)
            }
            .modelContainer(for: [CountryStorage.self])
        }
    }
}
