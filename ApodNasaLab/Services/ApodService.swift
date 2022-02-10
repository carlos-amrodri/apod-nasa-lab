//
//  ApodService.swift
//  ApodNasaLab
//
//  Created by Carlos Rodriguez on 10/02/2022.
//

import Foundation


class ApodService {
    
    private let apiKey = "R1H79V5cjSTGhVM50LPbObongcpFJzhGGHcMApsS"
    
    func getApodList(startDate: Date, endDate: Date, succes : @escaping([Apod])-> Void, failure : @escaping(CustomError)-> Void){
        let url = getUrl(startDate: startDate, endDate: endDate)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let _ = error { failure(CustomError.request) }
            guard let dato = data,
                  let respuesta = response as? HTTPURLResponse
            else{
                failure(CustomError.request)
                return
            }
            if respuesta.statusCode == 200 {
                do{
                    let decoder = JSONDecoder()
                    let arrayApod = try decoder.decode([Apod].self, from: dato)
                    succes(arrayApod)
                }catch{
                    failure(CustomError.parse)
                }
            }else{
                failure(CustomError.request)
            }
        }
        dataTask.resume()
    }
    
    private func getUrl(startDate: Date, endDate: Date)-> URL {
        let baseUrl = "https://api.nasa.gov/planetary/apod"
        var urlComponents = URLComponents(string: baseUrl)!
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "start_date", value: startDate.shortString()),
            URLQueryItem(name: "end_date", value: endDate.shortString())
        ]
        return urlComponents.url!
    }
 
}
