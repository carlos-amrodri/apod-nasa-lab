//
//  HomeInteractor.swift
//  ApodNasaLab
//
//  Created by Carlos Rodriguez on 10/02/2022.
//

import Foundation

protocol HomeInteractorProtocol {
    var presenter : HomePresenterProtocol? {get set}
    
    func loadApodListLastWeak()
}

class HomeInteractor: HomeInteractorProtocol {
    var presenter: HomePresenterProtocol?
    
    private var service = ApodService()
    
    func loadApodListLastWeak(){
        let hoy = Date()
        let resta = Calendar.current.date(byAdding: .day, value: -7, to: hoy)
        
        service.getApodList(startDate: resta!, endDate: hoy) { (apod) in
            print("apod: \(apod)")
            self.presenter?.reciveDidRequestApod(wit: .success(apod))
        } failure: { (error) in
            print("error: \(error)")
            self.presenter?.reciveDidRequestApod(wit: .failure(error))
        }

    }
    
    
    
}



