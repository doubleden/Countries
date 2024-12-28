//
//  CountryStorage.swift
//  Countries
//
//  Created by Denis Denisov on 28/12/24.
//

import SwiftData

@Model
final class CountryStorage {
    var name: String
    var currencies: String
    var capital: String
    var languages: String
    var latlng: [Double]
    var population: Int
    var flag: String
    var area: Double
    var region: String
    var timezones: [String]
    var isFavorite = false
    
    init(
        name: String,
        currencies: String,
        capital: String,
        languages: String,
        latlng: [Double],
        population: Int,
        flag: String,
        area: Double,
        region: String,
        timezones: [String]
    ) {
        self.name = name
        self.currencies = currencies
        self.capital = capital
        self.languages = languages
        self.latlng = latlng
        self.population = population
        self.flag = flag
        self.area = area
        self.region = region
        self.timezones = timezones
    }
}
