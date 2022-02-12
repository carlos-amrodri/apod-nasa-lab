//
//  DetailRouter.swift
//  ApodNasaLab
//
//  Created by Carlos Rodriguez on 11/02/2022.
//

import Foundation
import UIKit

typealias EntryPointDetail = DetailViewProtocol & UIViewController

protocol DetailRouterProtocol {
    var entry : EntryPointDetail? {get}
    
    static func createModule(with apod : Apod) -> DetailRouterProtocol
}

class DetailRouter: DetailRouterProtocol {
    
    var entry: EntryPointDetail?
    
    static func createModule(with apod: Apod) -> DetailRouterProtocol {
        let router = DetailRouter()
        
        var view : DetailViewProtocol = DetailView()
        var presenter : DetailPresenterProtocol = DetailPresenter(apod: apod, view: view)
        var interactor : DetailInteractorProtocol = DetailInteractor()
        
        view.presenter = presenter
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        
        router.entry = view as? EntryPointDetail
        return router
    }

    
}
