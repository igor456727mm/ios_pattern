//
//  Weather.swift
//  pattern
//
//  Created by Igor Selivestrov on 24.06.2020.
//  Copyright © 2020 Igor Selivestrov. All rights reserved.
//

import Foundation

struct Coordinate {
    var latitude: Double! = 55.75396
    var longitude: Double! = 37.620393
}
struct Weather:Decodable {
    var now:Double?
    var now_dt:String?
    var info: WeatherInfo?
    var fact: WeatherFact?
    var forecasts: [WeatherForecasts]?
    
    struct WeatherInfo:Decodable {
       
        var tzinfo: WeatherTazInfo?
        
        struct WeatherTazInfo:Decodable {
            var offset: Double?
            var name: String?
            var abbr: String?
            var dst: Bool?
        }
    }
    
    struct WeatherFact: Decodable {
        var temp: Int?
        var feels_like: Double?
        var temp_water: Double?
        var icon: String?
        var condition: String?
        var wind_speed: Double?
        var wind_gust: Double?
        var wind_dir: String?
        var pressure_mm: Int?
        
        var pressure_pa: Double?
        var humidity: Double?
        var daytime: String?
        var polar: Bool?
        var season: String?
        var obs_time: Double?
        var prec_type: Double?
        var prec_strength: Double?
        var cloudness: Double?
        
    }
    struct WeatherForecasts: Decodable {
        var temp: String?
        var date_ts: Double?
        var week: Double?
        var sunrise: String?
        var sunset: String?
        var moon_code: Double?
        var icon: String?
        var moon_text: String?
        var parts: Parts?
        var hours : [Hours]?
        
        struct Parts: Decodable {
            var evening: PartsEvening?
            var day: PartsEvening?
            var morning: PartsEvening?
            var night: PartsEvening?
            struct PartsEvening: Decodable {
                var temp_min: Double?
                var temp_max: Double?
                var temp_avg: Double?
                var feels_like: Double?
                var icon: String?
                var condition: String?
                var daytime: String?
                var polar: Bool?
                var wind_speed: Double?
                var wind_gust: Double?
                var wind_dir: String?
                var pressure_mm: Double?
                var pressure_pa: Double?
                var humidity: Double?
                var prec_mm: Double?
                var prec_period: Double?
                var prec_type: Double?
                var prec_strength: Double?
                var cloudness: Double?
                var _fallback_temp: Bool?
                var _fallback_prec: Bool?
            }
        }

        struct Hours:Decodable {
            var hour: String?
            var hour_ts: Double?
            var temp: Int?
            var feels_like: Double?
            var icon: String?
            var condition: String?
            var daytime: String?
            var polar: Bool?
            var wind_speed: Double?
            var wind_gust: Double?
            var wind_dir: String?
            var pressure_mm: Double?
            var pressure_pa: Double?
            var humidity: Double?
            var prec_mm: Double?
            var prec_period: Double?
            var prec_type: Double?
            var prec_strength: Double?
            var cloudness: Double?
            var _fallback_temp: Bool?
            var _fallback_prec: Bool?
        }
        
    }
    
}

