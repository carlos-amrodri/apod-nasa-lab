//
//  HomePresenter.swift
//  ApodNasaLab
//
//  Created by Carlos Rodriguez on 10/02/2022.
//

import Foundation
import UIKit


protocol HomePresenterProtocol {
    var router     : HomeRouterProtocol?     {get set}
    var view       : HomeViewProtocol?       {get set}
    var interactor : HomeInteractorProtocol? {get set}

    func reciveDidRequestApod(wit result: Result<[Apod], CustomError>)
    func navigateToDetail(with apodSelected : Apod, context : UIViewController)
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
    
    func navigateToDetail(with apodSelected : Apod, context : UIViewController){
        router?.navigateToDetail(apod: apodSelected, context: context)
    }
    
}


