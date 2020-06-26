//
//  NetworkService.swift
//  pattern
//
//  Created by Igor Selivestrov on 21.06.2020.
//  Copyright © 2020 Igor Selivestrov. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

protocol NetworkServiceProtocol {
    func getPost(completion: @escaping (Result<[Post]?, Error>) -> Void)
    func getWeather(local: CLLocation, completion: @escaping (Result<Weather?, Error>) -> Void)
    func getCityimage(cityName: String?, completion: @escaping (Result<City?, Error>) -> Void)
}
class NetworkService: NetworkServiceProtocol {
    func getCityimage(cityName: String?, completion: @escaping (Result<City?, Error>) -> Void) {
        
        guard let urlString = (Setting.shared.urlCityimage!  + "&q=\(String(cityName!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!))") as String? else { return  }
        
         guard let url = URL(string: urlString) else { return }
        print(urlString)
        let task = URLSession.shared.dataTask(with: url) { (data, response, error ) in
             
             if error != nil {
                 completion(.failure(error!))
                 return
             }
             guard let data = data else { return }
             do {
                 let  jsonString = try JSONDecoder().decode(City.self, from: data)
                 
                 completion(.success(jsonString))
             } catch {
                 completion(.failure(error))
             }
             
             
         }
         .resume()
    }
    
    func getWeather(local: CLLocation, completion: @escaping (Result<Weather?, Error>) -> Void) {
        guard let urlString = (Setting.shared.urlWeather!  + "&lat=\(local.coordinate.latitude)&lon=\(local.coordinate.longitude)") as String? else { return  }
       
        guard let url = URL(string: urlString) else { return }
        
        let request = NSMutableURLRequest(url: url)
        request.timeoutInterval = 60
        request.httpMethod = "GET"
        request.setValue(Setting.shared.valueApi, forHTTPHeaderField: Setting.shared.keyApi)
        
        let taskone = URLSession.shared.dataTask(with: request as URLRequest) { (data, responce, error) in
            if error != nil {
                    completion(.failure(error!))
                    return
                }
                guard let data = data else { return }
                do {
                    let  jsonString = try JSONDecoder().decode(Weather.self, from: data)
                    completion(.success(jsonString))
                } catch {
                    completion(.failure(error))
                }
                
                
            }
            .resume()
       
    }
    func getPost(completion: @escaping (Result<[Post]?, Error>) -> Void) {
        
        guard let urlString = Setting.shared.urlString as String? else { return  }
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error ) in
            
            if error != nil {
                completion(.failure(error!))
                return
            }
            guard let data = data else { return }
            do {
                let  jsonString = try JSONDecoder().decode([Post].self, from: data)
                
                completion(.success(jsonString))
            } catch {
                completion(.failure(error))
            }
            
            
        }
        .resume()
    }
    
    
    class func fetch(completion: @escaping (String) -> ())
    {
        guard let urlString = Setting.shared.urlString as String? else { return  }
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error ) in
            if error != nil {
                print("error")
            }
            guard let data = data else { return }
            guard let  jsonString = String(data: data, encoding: .utf8) else { return }
            completion(jsonString)
        }
        task.resume()
        
    }
}
