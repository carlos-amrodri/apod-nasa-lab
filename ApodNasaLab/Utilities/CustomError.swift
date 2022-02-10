//
//  CustomError.swift
//  ApodNasaLab
//
//  Created by Carlos Rodriguez on 10/02/2022.
//

import Foundation


enum CustomError : Error {
    case request, parse
    var description : String {
        get {
            switch(self){
            case .request : return "Ops! ocurrio un error al buscar los datos"
            case .parse : return "Ops! no logramos configurar los datos"
            }
        }
    }
}
