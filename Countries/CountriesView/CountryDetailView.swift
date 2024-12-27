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
    let country: Country
    @Environment(\.screenSize) private var screenSize
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                // Изображение флага
                KFImage(URL(string: country.flags?.png ?? ""))
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
                        text: country.capital?.first ?? "N/A"
                    )
                    
                    DescriptionView(
                        title: "Population",
                        text: country.population?.formatted() ?? "N/A"
                    )
                    
                    DescriptionView(
                        title: "Area",
                        text: country.area?.formatted() ?? "N/A"
                    )
                    
                    DescriptionView(
                        title: "Currencies",
                        text: country.currencies?.first?.value.name ?? "N/A"
                    )
                    
                    DescriptionView(
                        title: "Languages",
                        text: country.languages?.first?.value ?? "N/A"
                    )
                    
                    DescriptionView(
                        title: "Timezones",
                        text: country.timezones?.first ?? "N/A"
                    )
                    
                    ShareLink(
                        item: country.flags?.png ?? "",
                        preview: SharePreview(country.name?.official ?? "", image: Image(systemName: "link"))
                    )
                    .padding()
                    
                    if let lat = country.latlng?[0], let lng = country.latlng?[1] {
                        MapView(
                            coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lng),
                            zoomLevel: 130,
                            annotationTitle: country.name?.official ?? "Unknown Location"
                        )
                        .frame(height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.vertical)
                    } else {
                        Text("No location data available")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                .frame(width: screenSize.width * 0.8)
                .padding(.top)
            }
        }
        .navigationTitle(country.name?.official ?? "Country Details")
    }
}

struct MapView: View {
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
            country: Country(
                name: CountryName(official: "Russia"),
                currencies: ["rub": CountryCurrenciesValue(name: "Ruble")],
                capital: ["Moscow"],
                languages: ["ru": "Russian"],
                latlng: [60, 100],
                population: 2000000,
                flags: CountryFlags(png: "https://flagcdn.com/w320/ru.png"),
                area: 50000.22,
                timezones: ["UTC+03:00"]
            )
        )
    }
}
