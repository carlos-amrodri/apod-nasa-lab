//
//  HomePresenter.swift
//  ApodNasaLab
//
//  Created by Carlos Rodriguez on 10/02/2022.
//

import Foundation


protocol HomePresenterProtocol {
    var router     : HomeRouterProtocol?     {get set}
    var view       : HomeViewProtocol?       {get set}
    var interactor : HomeInteractorProtocol? {get set}

    func reciveDidRequestApod(wit result: Result<[Apod], CustomError>)
}


class HomePresenter : HomePresenterProtocol {
    var router: HomeRouterProtocol?
    var view: HomeViewProtocol?
    var interactor : HomeInteractorProtocol? {
        didSet{
            interactor?.loadApodListLastWeak()
        }
    }
    
    func reciveDidRequestApod(wit result: Result<[Apod], CustomError>){
        switch result {
        case .success(let apods):
            view?.showDataApod(apodList: apods)
        case .failure(let error) :
            view?.showErrorMessage(error: error)
        }
    }
    
}


