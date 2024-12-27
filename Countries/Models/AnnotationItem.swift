//
//  AnotationItem.swift
//  Countries
//
//  Created by Denis Denisov on 28/12/24.
//

import MapKit

struct AnnotationItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String?
}
