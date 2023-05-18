//
//  ContentView.swift
//  WeatherApp
//
//  Created by Misha Vrana on 04.05.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    @StateObject var weatherManager = WeatherManager()
    @State private var offset = CGFloat.zero
    
    var body: some View {
        
        ZStack(alignment: .top) {
            ZStack {
                UpdateRing(offsetNeed: 110, offsetStart: offset)
                    .frame(width: 50)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color(hue: 0.713, saturation: 0.923, brightness: 0.608))
            
            VStack {
                if let location = locationManager.location {
                    if let weather = weatherManager.weather {
                        WeatherView(weather: weather)
                    } else {
                        LoadingView()
                            .task {
                                do {
                                    try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                } catch {
                                    print("Error getting weather \(error.localizedDescription)")
                                }
                            }
                    }
                } else {
                    LoadingView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                locationManager.requestLocation()
            }
            .background(Color(hue: 0.713, saturation: 0.923, brightness: 0.608))
            .preferredColorScheme(.dark)
            .offset(y: offset)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        withAnimation(Animation.linear) {
                            if(gesture.translation.height < 110 && gesture.translation.height >= 0) {
                                offset = gesture.translation.height * 1.5
                            }
                        }
                        
                    }
                    .onEnded { gesture in
                        if (offset > 0) {
                            locationManager.requestLocation()
                            weatherManager.weather = nil
                        offset = .zero
                        }
                    }
            )
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
