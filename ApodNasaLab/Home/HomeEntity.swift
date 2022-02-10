//
//  HomeEntity.swift
//  ApodNasaLab
//
//  Created by Carlos Rodriguez on 10/02/2022.
//

import Foundation


struct Apod : Codable {
    var date : String
    var explanation : String
    var media_type : mediType
    var title : String
    var url : String
}

enum mediType: String, CodingKey, Codable {
    case video = "video"
    case image = "image"
}
