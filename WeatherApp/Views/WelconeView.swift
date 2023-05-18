//
//  WelconeView.swift
//  WeatherApp
//
//  Created by Misha Vrana on 06.05.2023.
//

import SwiftUI
import CoreLocationUI

struct WelconeView: View {
    @EnvironmentObject var locationManager: LocationManager
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Welcome to the weather App")
                    .bold().font(.title)
                Text("Share the current location to get the weather in your area")
                    .padding()
            }
            .multilineTextAlignment(.center)
            .padding()
            
            LocationButton(.shareCurrentLocation) {
                locationManager.requestLocation()
            }
            .cornerRadius(30)
            .symbolVariant(.fill)
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        // VStack will take all space it can
    }
}

struct WelconeView_Previews: PreviewProvider {
    static var previews: some View {
        WelconeView()
    }
}
