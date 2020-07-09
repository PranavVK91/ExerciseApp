//
//  MainViewController.swift.swift
//  ExerciseApp
//
//  Created by Pranav V K on 08/07/20.
//  Copyright © 2020 Pranav V K. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var countryTableView = UITableView()
    
    let viewModel = CountryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if connectedToNetwork() {
            viewModel.loadData(handler: { isLoaded in
                if isLoaded {
                    weak var weakself = self
                    DispatchQueue.main.async {
                        weakself?.countryTableView.reloadData()
                    }
                } else {
                    weak var weakself = self
                    DispatchQueue.main.async {
                        weakself?.showAlert(title: "Unable to fetch data", Message: "Please refresh")
                    }
                }
            })
        } else {
            showAlert(title: "No Internet Connectivity", Message: "Please connect to mobile data or WiFi")
        }
    }
    
    func configureTableView() {
        view.addSubview(countryTableView)
        setTableViewDelegate()
        countryTableView.rowHeight = 50
    }
    
    func setTableViewDelegate() {
        countryTableView.dataSource = self
    }
    
    func showAlert(title : String , Message : String) {
        let alert = UIAlertController(title: title, message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.countryModel?.details.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
