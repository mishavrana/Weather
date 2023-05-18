//
//  UpdateRing.swift
//  WeatherApp
//
//  Created by Misha Vrana on 08.05.2023.
//

import SwiftUI

struct UpdateRing: View {
    var offsetNeed: CGFloat
    var offsetStart: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 1)
                .stroke(Color.black.opacity(0.09), style: StrokeStyle(lineWidth: 5, lineCap: .round))
            Circle()
                .trim(from: 0, to: 0 + (offsetStart / offsetNeed))
                .stroke(Color.green.opacity(0.8), style: StrokeStyle(lineWidth: 5, lineCap: .round)
                )
        }
        .rotationEffect(.init(degrees: -90))
    }
}

struct UpdateRing_Previews: PreviewProvider {
    static var previews: some View {
        UpdateRing(offsetNeed: 100, offsetStart: 70)
    }
}
