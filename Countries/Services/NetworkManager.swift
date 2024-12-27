//
//  NetworkManager.swift
//  Countries
//
//  Created by Denis Denisov on 24/12/24.
//

import Foundation
import restcountries

enum NetworkError: Error {
    case noData
    case invalidURL
    case decodingError
    case invalidResponse
    
    var description: String {
        switch self {
        case .noData:
            "Missing Data"
        case .invalidURL:
            "Invalid URL"
        case .decodingError:
            "Decoding Error"
        case .invalidResponse:
            "Invalid Response from server"
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData() async throws -> [Country] {
        guard let url = URL(string: "https://restcountries.com/v3.1/all") else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        do {
            let jsonString = String(data: data, encoding: .utf8)
                print("JSON Response: \(jsonString ?? "No Data")")
            return try decoder.decode([Country].self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}
