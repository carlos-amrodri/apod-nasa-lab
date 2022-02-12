//
//  HomeView.swift
//  ApodNasaLab
//
//  Created by Carlos Rodriguez on 10/02/2022.
//

import Foundation
import UIKit

protocol HomeViewProtocol {
    var presenter : HomePresenterProtocol? {get set}
    
    func showDataApod(apodList : [Apod])
    func showErrorMessage(error : CustomError)
    
}

class HomeView : UIViewController, HomeViewProtocol, UITableViewDelegate, UITableViewDataSource {

    var presenter: HomePresenterProtocol?
    
    var apodList : [Apod] = []
    
    var activityIndicator : UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.color = .white
        activity.isHidden = false
        activity.startAnimating()
        return activity
    }()
    
    private let tableView : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = false
        table.backgroundColor = .darkGray
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func showDataApod(apodList: [Apod]) {
        DispatchQueue.main.async {
            self.apodList = apodList
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
    
    func showErrorMessage(error: CustomError) {
        print("ops hay error: \(error)")
    }
    
    private func setupViews(){
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.title = "NASA Apods"
        
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        apodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = apodList[indexPath.row].title
        cell.backgroundColor = .darkGray
        cell.textLabel?.textColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let apod = apodList[indexPath.row]
        presenter?.navigateToDetail(with: apod, context: self)
    }
    
}
