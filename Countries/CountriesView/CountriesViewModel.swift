//
//  CountriesViewModel.swift
//  Countries
//
//  Created by Denis Denisov on 24/12/24.
//

import Observation
import restcountries
import SwiftData

@Observable
final class CountriesViewModel {
    var modelContext: ModelContext?
    var isLoading = true
    
    private let networkManager = NetworkManager.shared
    
    
    func fetchCountries() async {
        guard let modelContext = modelContext else { return }
        do {
            let countries = try await networkManager.fetchData()
            for country in countries {
                let countryStorage = CountryStorage(
                    name: country.name?.official ?? "",
                    currencies: country.currencies?.first?.key ?? "",
                    capital: country.capital?.first ?? "",
                    languages: country.languages?.first?.value ?? "",
                    latlng: country.latlng ?? [],
                    population: country.population ?? 0,
                    flag: country.flags?.png ?? "",
                    area: country.area ?? 0,
                    region: country.region ?? "",
                    timezones: country.timezones ?? []
                )
                
                StorageManager.shared.save(country: countryStorage, context: modelContext)
            }
            isLoading = false
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func toggleFavorite(country: CountryStorage) {
        country.isFavorite.toggle()
    }
}
