//
//  DetailPresenter.swift
//  ApodNasaLab
//
//  Created by Carlos Rodriguez on 11/02/2022.
//

import Foundation
import UIKit

protocol DetailPresenterProtocol  {
    var interactor : DetailInteractorProtocol? {get set}
    
    func getDataLabels()
    func getImage()
    
    func didLoadData( data : Data)
}

class DetailPresenter: DetailPresenterProtocol {
    
    var view: DetailViewProtocol!
    
    var interactor: DetailInteractorProtocol?
    
    var apod: Apod
    
    init(apod : Apod, view : DetailViewProtocol) {
        self.apod = apod
        self.view = view
    }
    
    func getDataLabels(){
        view.updateLabelsText(title: apod.title, detail: apod.explanation)
    }
    

    
    func didLoadData( data : Data){
        guard let image = UIImage(data: data) else { return }
        view.showImage(with: image)
    }
    
    func getImage(){
        switch apod.media_type {
        case .image :
            guard let url = URL(string: apod.url) else {return}
            interactor?.loadDataImage(with: url)
        case .video :
            view.showPlayerView(with: getIdVideo())
        }
    }
    
    
    private func getIdVideo() -> String {
        let urlArray = apod.url.components(separatedBy: "embed/")
        let urlCut = urlArray[1]
        if let index = urlCut.lastIndex(of: "?"){
            let sub = urlCut[..<index]
            return String(sub)
        }
        return ""
        
    }

    

    

    
}
