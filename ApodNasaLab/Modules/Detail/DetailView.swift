//
//  DetailView.swift
//  ApodNasaLab
//
//  Created by Carlos Rodriguez on 10/02/2022.
//

import UIKit


class DetailView: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var apodImage: UIImageView!
    @IBOutlet weak var nasaBackImage: UIImageView!
    
    var apod: Apod
    
    init(apod : Apod) {
        self.apod = apod
        super.init(nibName: "DetailView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        titleLabel.text = apod.title

        descriptionLabel.text = apod.explanation
        
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if apod.media_type == .image {
            loadImage()
        }
    }
    
    private func loadImage(){
        guard let url = URL(string: apod.url) else { return }
        if let data = try? Data(contentsOf: url){
            if let image = UIImage(data: data){
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
    }
    
 

}
