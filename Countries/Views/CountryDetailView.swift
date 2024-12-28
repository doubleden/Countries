//
//  CountryDetailView.swift
//  Countries
//
//  Created by Denis Denisov on 27/12/24.
//

import SwiftUI
import restcountries
import Kingfisher
import MapKit

struct CountryDetailView: View {
    let country: CountryStorage
    @Binding var countriesVM: CountriesViewModel
    @Environment(\.screenSize) private var screenSize
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                // Изображение флага
                KFImage(URL(string: country.flag))
                    .placeholder {
                        ProgressView()
                    }
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenSize.width * 0.8)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke()
                    )
                
                VStack {
                    // Описание страны
                    DescriptionView(
                        title: "Capital",
                        text: country.capital
                    )
                    
                    DescriptionView(
                        title: "Population",
                        text: country.population.formatted()
                    )
                    
                    DescriptionView(
                        title: "Area",
                        text: country.area.formatted()
                    )
                    
                    DescriptionView(
                        title: "Currencies",
                        text: country.currencies
                    )
                    
                    DescriptionView(
                        title: "Languages",
                        text: country.languages
                    )
                    
                    DescriptionView(
                        title: "Timezones",
                        text: country.timezones.first ?? ""
                    )
                    
                    ShareLink(
                        item: country.flag,
                        preview: SharePreview(country.name, image: Image(systemName: "link"))
                    )
                    .padding()
                    
                    MapView(
                        coordinate: CLLocationCoordinate2D(latitude: country.latlng.first ?? 0, longitude: country.latlng.last ?? 0),
                        zoomLevel: 130,
                        annotationTitle: country.name
                    )
                    .frame(height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.vertical)
                }
                .frame(width: screenSize.width * 0.8)
                .padding(.top)
            }
        }
        .navigationTitle(country.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    countriesVM.toggleFavorite(country: country)
                }) {
                    Image(systemName: country.isFavorite ? "heart.fill" : "heart")
                }
            }
        }
    }
}

fileprivate struct MapView: View {
    let coordinate: CLLocationCoordinate2D
    let zoomLevel: Double
    let annotationTitle: String?
    
    @State private var region: MKCoordinateRegion
    
    init(coordinate: CLLocationCoordinate2D, zoomLevel: Double = 15.0, annotationTitle: String? = nil) {
        self.coordinate = coordinate
        self.zoomLevel = zoomLevel
        self.annotationTitle = annotationTitle
        _region = State(initialValue: MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: zoomLevel, longitudeDelta: zoomLevel)
        ))
    }
    
    @available(iOS, introduced: 14.0, deprecated: 17.0, message: "Обновить код до использования MapContentBuilder")
    var body: some View {
        Map(
            coordinateRegion: $region,
            annotationItems: [AnnotationItem(coordinate: coordinate, title: annotationTitle)]
        ) { item in
            MapAnnotation(coordinate: item.coordinate) {
                VStack {
                    Image(systemName: "mappin.circle.fill")
                        .resizable()
                        .foregroundColor(.red)
                        .frame(width: 30, height: 30)
                    if let title = item.title {
                        Text(title)
                            .font(.caption)
                            .foregroundColor(.black)
                            .background(Color.white.opacity(0.7))
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                }
            }
        }
    }
}

fileprivate struct DescriptionView: View {
    let title: String
    let text: String
    
    var body: some View {
        HStack {
            Text("\(title):")
                .fontWeight(.semibold)
            Spacer()
            Text(text)
                .multilineTextAlignment(.trailing)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        CountryDetailView(
            country: CountryStorage(
                name: "Russia",
                currencies: "Ruble",
                capital: "Moscow",
                languages: "Russian",
                latlng: [60, 100],
                population: 2000000,
                flag: "https://flagcdn.com/w320/ru.png",
                area: 50000.22,
                region: "",
                timezones: ["UTC+03:00"]
            ), countriesVM: .constant(CountriesViewModel())
        )
    }
}
