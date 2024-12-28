//
//  StorageManager.swift
//  Countries
//
//  Created by Denis Denisov on 28/12/24.
//

import Foundation
import SwiftData

final class StorageManager {
    
    static let shared = StorageManager()
    
    private init() {}
    
    func save(country: CountryStorage, context: ModelContext) {
        DispatchQueue.main.async {
            context.insert(country)
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
    
    func delete(country: CountryStorage, context: ModelContext) {
        DispatchQueue.main.async {
            do {
                context.delete(country)
                try context.save()
            } catch {
                print(error)
            }
        }
    }
    
    func deleteAll(countries: [CountryStorage], context: ModelContext) {
        DispatchQueue.main.async {
            do {
                for country in countries {
                    context.delete(country)
                }
                try context.save()
            } catch {
                print(error)
            }
        }
    }
}
