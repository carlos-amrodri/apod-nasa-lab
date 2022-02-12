//
//  DetailInteractor.swift
//  ApodNasaLab
//
//  Created by Carlos Rodriguez on 11/02/2022.
//

import Foundation

protocol DetailInteractorProtocol {
    var presenter : DetailPresenterProtocol? {get set}
    
    func loadDataImage(with url : URL)
}

class DetailInteractor: DetailInteractorProtocol {
    
    var presenter: DetailPresenterProtocol?
    
    func loadDataImage(with url : URL){
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        presenter?.didLoadData(data: data)
    }
}
