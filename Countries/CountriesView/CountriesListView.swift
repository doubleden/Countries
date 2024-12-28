//
//  CountriesListView.swift
//  Countries
//
//  Created by Denis Denisov on 24/12/24.
//

import SwiftUI
import restcountries
import SwiftData

struct CountriesListView: View {
    
    @Query var countries: [CountryStorage]
    @State private var countriesVM = CountriesViewModel()
    
    @Environment(\.screenSize) private var screenSize
    @Environment(\.modelContext) private var modelContext
    
    @State private var searchText = ""
    
    @AppStorage("firstLaunch") private var isFirstLaunch = true
    
    var filteredItems: [CountryStorage] {
        searchText.isEmpty
        ? countries
        : countries.filter { $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        ZStack {
            if countriesVM.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                List(filteredItems, id: \.self) { country in
                    NavigationLink {
                        CountryDetailView(country: country, countriesVM: $countriesVM)
                    } label: {
                        CellView(
                            name: country.name,
                            region: country.region,
                            flagImageName: country.flag
                        )
                    }
                }
                .searchable(text: $searchText, prompt: "Search country")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink(destination: CountriesListFavoritesView(countriesVM: $countriesVM)) {
                            Image(systemName: "star")
                        }
                    }
                }
            }
        }
        .navigationTitle("All countries")
        .onAppear {
            countriesVM.modelContext = modelContext
            if isFirstLaunch {
                Task {
                    await countriesVM.fetchCountries()
                }
                isFirstLaunch = false
            } else {
                countriesVM.isLoading = false 
            }
        }
    }
}


