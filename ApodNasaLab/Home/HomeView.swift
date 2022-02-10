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
    
    private let tableView : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = false
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func showDataApod(apodList: [Apod]) {
        DispatchQueue.main.async {
            self.apodList = apodList
            self.tableView.reloadData()
        }
    }
    
    func showErrorMessage(error: CustomError) {
        print("ops hay error: \(error)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        apodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = apodList[indexPath.row].title
        return cell
    }
    
}
