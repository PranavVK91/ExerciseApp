//
//  MainViewController.swift.swift
//  ExerciseApp
//
//  Created by Pranav V K on 08/07/20.
//  Copyright © 2020 Pranav V K. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let viewModel = CountryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if connectedToNetwork() {
            viewModel.loadData(handler: { isLoaded in
                if isLoaded {
                    weak var weakself = self
                    DispatchQueue.main.async {
                        weakself?.showAlert(title: "Success", Message: "hurray")
                        //TODO: Update UI Here
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
    
    func showAlert(title : String , Message : String) {
        let alert = UIAlertController(title: title, message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
