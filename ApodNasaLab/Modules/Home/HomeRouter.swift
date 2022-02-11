//
//  HomeRouter.swift
//  ApodNasaLab
//
//  Created by Carlos Rodriguez on 10/02/2022.
//

import Foundation
import UIKit

typealias EntryPoint = HomeViewProtocol & UIViewController

protocol HomeRouterProtocol {
    var entry : EntryPoint? {get}
    
    static func createModule() -> HomeRouterProtocol

    func navigateToDetail(apod : Apod, context : UIViewController)
}

class HomeRouter: HomeRouterProtocol {
    
    var entry: EntryPoint?
    
    static func createModule() -> HomeRouterProtocol {
        let router = HomeRouter()
        
        var view : HomeViewProtocol = HomeView()
        var presenter : HomePresenterProtocol = HomePresenter()
        var interactor : HomeInteractorProtocol = HomeInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.entry = view as? EntryPoint
        return router
    }
    
    func navigateToDetail(apod : Apod, context : UIViewController) {
        let vc = DetailView(apod: apod)
        context.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
