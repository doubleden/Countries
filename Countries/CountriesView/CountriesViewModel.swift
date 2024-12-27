//
//  CountriesViewModel.swift
//  Countries
//
//  Created by Denis Denisov on 24/12/24.
//

import Observation
import restcountries

@Observable
final class CountriesViewModel {
    var countries: [Country] = []
    var isLoading = true
    
    private let networkManager = NetworkManager.shared
    
    func fetchCountries() async {
        do {
            countries = try await networkManager.fetchData()
            isLoading = false
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
