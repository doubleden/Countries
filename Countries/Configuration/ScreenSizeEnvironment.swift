//
//  ScreenSizeEnvironment.swift
//  Countries
//
//  Created by Denis Denisov on 27/12/24.
//

import SwiftUI

fileprivate struct ScreenSizeKey: EnvironmentKey {
    static let defaultValue = UIScreen.main.bounds.size
}

extension EnvironmentValues {
    var screenSize: CGSize {
        get { self[ScreenSizeKey.self] }
        set { self[ScreenSizeKey.self] = newValue }
    }
}
