//
//  CountriesListFavoritesView.swift
//  Countries
//
//  Created by Denis Denisov on 28/12/24.
//

import SwiftUI
import SwiftData

struct CountriesListFavoritesView: View {
    @Binding var countriesVM: CountriesViewModel
    
    @Query(filter: #Predicate<CountryStorage> { $0.isFavorite })
    private var favoriteCountries: [CountryStorage]
    
    var body: some View {
        ZStack {
            List(favoriteCountries, id: \.self) { country in
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
        }
        .navigationTitle("Favorite countries")
    }
}


