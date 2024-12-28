//
//  CellView.swift
//  Countries
//
//  Created by Denis Denisov on 28/12/24.
//

import SwiftUI
import Kingfisher

struct CellView: View {
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
