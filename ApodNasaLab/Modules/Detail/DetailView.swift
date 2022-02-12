//
//  DetailView.swift
//  ApodNasaLab
//
//  Created by Carlos Rodriguez on 10/02/2022.
//

import UIKit

protocol DetailViewProtocol {
    var presenter : DetailPresenterProtocol? {get set}
    
    func showImage(with image : UIImage)
    func updateLabelsText(title:String, detail:String)
}


class DetailView: UIViewController, DetailViewProtocol {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var apodImage: UIImageView!
    @IBOutlet weak var nasaBackImage: UIImageView!
    
    var presenter: DetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.getDataLabels()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter?.getImage()
    }

    
    func updateLabelsText(title:String, detail:String){
        titleLabel.text = title
        descriptionLabel.text = detail
    }
    
    func showImage(with image : UIImage){
        DispatchQueue.main.async {
            self.apodImage.image = image
            UIView.animate(withDuration: 0.8) {
                self.nasaBackImage.alpha = 0
                self.apodImage.isHidden = false
            } completion: { _ in
                UIView.animate(withDuration: 0.8) {
                    self.apodImage.alpha = 1
                    self.nasaBackImage.isHidden = true
                }
            }
        }
    }
    

}
