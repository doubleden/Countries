//
//  Country.swift
//  Countries
//
//  Created by Denis Denisov on 24/12/24.
//

import Foundation

struct Country: Codable {
    let name: Name
    let tld: [String]?
    let cca2: String
    let ccn3: String?
    let cca3: String
    let independent: Bool?
    let status: String
    let unMember: Bool
    let currencies: [String: Currency]?
    let idd: IDD
    let capital: [String]?
    let altSpellings: [String]
    let region: String
    let subregion: String?
    let languages: [String: String]?
    let translations: [String: Translation]
    let latlng: [Double]
    let landlocked: Bool
    let area: Double
    let demonyms: Demonyms?
    let flag: String
    let maps: Maps
    let population: Int
    let car: Car?
    let timezones: [String]
    let continents: [String]
    let flags: Flags
    let coatOfArms: CoatOfArms?
    let startOfWeek: String?
    let capitalInfo: CapitalInfo?
}

// MARK: - Name
struct Name: Codable {
    let common: String
    let official: String
    let nativeName: [String: Translation]?
}

// MARK: - Translation
struct Translation: Codable {
    let official: String
    let common: String
}

// MARK: - Currency
struct Currency: Codable {
    let name: String
    let symbol: String?
}

// MARK: - IDD
struct IDD: Codable {
    let root: String?
    let suffixes: [String]
}

// MARK: - Demonyms
struct Demonyms: Codable {
    let eng: Gender?
    let fra: Gender?
}

// MARK: - Gender
struct Gender: Codable {
    let f: String
    let m: String
}

// MARK: - Maps
struct Maps: Codable {
    let googleMaps: String
    let openStreetMaps: String
}

// MARK: - Car
struct Car: Codable {
    let signs: [String]?
    let side: String
}

// MARK: - Flags
struct Flags: Codable {
    let png: String
    let svg: String
}

// MARK: - CoatOfArms
struct CoatOfArms: Codable {}

// MARK: - CapitalInfo
struct CapitalInfo: Codable {
    let latlng: [Double]?
}
