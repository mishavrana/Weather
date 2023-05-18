//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Misha Vrana on 07.05.2023.
//

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather.name)
                        .bold().font(.title)
                    
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                VStack {
                    HStack {
                        VStack(spacing: 20) {
                            getConditionBasedWeatherLogo(for: weather)
                                .font(.system(size: 40))
                            Text(weather.weather[0].main)
                        }
                        .frame(width: 150, alignment: .leading)
                        
                        Spacer()
                        
                        Text(weather.main.feels_like.roundDouble() + "°")
                            .font(.system(size: 90))
                            .fontWeight(.bold)
                            .padding()
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 20) {
                    Text("Weather now")
                        .bold().padding(.bottom)
                    HStack {
                        WeatherRow(logo: "thermometer", name: "Min temp", value: weather.main.temp_min.roundDouble() + "°" )
                        Spacer()
                        WeatherRow(logo: "thermometer", name: "Max temp", value: weather.main.temp_max.roundDouble() + "°" )
                    }
                    HStack {
                        WeatherRow(logo: "wind", name: "Wind speed", value: weather.wind.speed.roundDouble() + "m/s" )
                        Spacer()
                        WeatherRow(logo: "humidity", name: "Humidity", value: weather.main.humidity.roundDouble() + "%" )
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color(hue: 0.713, saturation: 0.923, brightness: 0.608))
                .background(.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.713, saturation: 0.923, brightness: 0.608))
        .preferredColorScheme(.dark)
    }
    
    
}

func getConditionBasedWeatherLogo(for weather: ResponseBody) -> Image {
    switch weather.weather[0].main {
    case "Clear":
        return Image(systemName: "sun.max")
    case "Clouds":
        return Image(systemName: "cloud.sun")
    case "Rain":
        return Image(systemName: "cloud.heavyrain")
    case "Thunderstorm":
        return Image(systemName: "cloud.bolt.rain")
    case "Snow":
        return Image(systemName: "snowflake")
    case "Fogg":
        return Image(systemName: "cloud.fog")
    default:
        return Image(systemName: "cloud.sun")
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}
