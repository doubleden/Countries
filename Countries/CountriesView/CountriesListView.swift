//
//  CountriesListView.swift
//  Countries
//
//  Created by Denis Denisov on 24/12/24.
//

import SwiftUI
import Kingfisher
import restcountries

struct CountriesListView: View {
    @State private var countriesVM = CountriesViewModel()
    @Environment(\.screenSize) private var screenSize
    
    @State private var searchText = ""
    
    var filteredItems: [Country] {
        searchText.isEmpty
        ? countriesVM.countries
        : countriesVM.countries.filter { country in
            guard let countryName = country.name?.official else {
                return false
            }
            return countryName.localizedCaseInsensitiveContains(searchText)
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
                        CountryDetailView(country: country)
                    } label: {
                        CellView(
                            name: country.name?.official ?? "",
                            region: country.region ?? "",
                            flagImageName: country.flags?.png ?? ""
                        )
                    }

                }
                .searchable(text: $searchText, prompt: "Search country")
            }
        }
        .task {
            await countriesVM.fetchCountries()
        }
    }
}

fileprivate struct CellView: View {
    let name: String
    let region: String
    let flagImageName: String
    
    @Environment(\.screenSize) private var screenSize
    
    var body: some View {
        HStack(spacing: 20) {
            Text(name)
            Spacer()
            VStack(alignment: .trailing) {
                KFImage(URL(string: flagImageName))
                    .placeholder {
                        ProgressView()
                    }
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenSize.width * 0.1)
                Text(region)
                    .multilineTextAlignment(.trailing)
            }
        }
    }
}

#Preview {
    NavigationStack {
            CountriesListView()
    }
}
