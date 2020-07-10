//
//  MainViewController.swift.swift
//  ExerciseApp
//
//  Created by Pranav V K on 08/07/20.
//  Copyright © 2020 Pranav V K. All rights reserved.
//

import UIKit
import PureLayout

class MainViewController: UIViewController {
    var countryTableView = UITableView(forAutoLayout: ())
    let loader = UIActivityIndicatorView(forAutoLayout: ())
    var uiRefresher = UIRefreshControl(forAutoLayout: ())
    let navigationBar = UINavigationBar(forAutoLayout: ())
    
    var viewModel = CountryViewModel()
    
    var canMakeWebServiceCall = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .white
        showLoadingAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataAndUpdateView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpNavigationBar()
        configureTableView()
    }
    
    @objc func fetchDataAndUpdateView() {
        if connectedToNetwork() && canMakeWebServiceCall {
            self.uiRefresher.endRefreshing()
            showLoadingAnimation()
            canMakeWebServiceCall = false
            viewModel.loadData(handler: { isLoaded in
                if isLoaded {
                    weak var weakself = self
                    weakself?.canMakeWebServiceCall = true
                    DispatchQueue.main.async {
                        weakself?.loader.stopAnimating()
                        weakself?.countryTableView.isHidden = false
                        weakself?.updateNavigationBarTitle(with: self.viewModel.countryModel?.title ?? "")
                        weakself?.countryTableView.reloadData()
                    }
                } else {
                    weak var weakself = self
                    weakself?.canMakeWebServiceCall = true
                    DispatchQueue.main.async {
                        weakself?.showAlert(title: "Unable to fetch data", Message: "Please refresh")
                    }
                }
            })
        } else {
            showAlert(title: "No Internet Connectivity", Message: "Please connect to mobile data or WiFi")
        }
    }
    
    func showLoadingAnimation() {
        loader.color = .black
        loader.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        self.view.addSubview(loader)
        loader.startAnimating()
        loader.autoCenterInSuperview()
    }
    
    func configureTableView() {
        view.addSubview(countryTableView)
        countryTableView.register(CountryTableViewCell.self, forCellReuseIdentifier: "CountryTableViewCell")
        countryTableView.isHidden = true
        countryTableView.separatorStyle = .none
        countryTableView.allowsSelection = false
        setTableViewDelegate()
        setTableViewConstraints()
        setUpUIRefresher()
    }
    
    func setTableViewDelegate() {
        countryTableView.dataSource = self
    }
    
    func setTableViewConstraints() {
        countryTableView.autoPinEdge(.top, to: .bottom, of: self.navigationBar)
        countryTableView.autoPinEdge(toSuperviewEdge: .bottom)
        countryTableView.autoPinEdge(toSuperviewEdge: .right)
        countryTableView.autoPinEdge(toSuperviewEdge: .left)
    }
    
    func setUpUIRefresher() {
        self.countryTableView.addSubview(uiRefresher)
        uiRefresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        uiRefresher.tintColor = .black
        uiRefresher.addTarget(self, action: #selector(fetchDataAndUpdateView), for: .valueChanged)
    }
    
    func setUpNavigationBar() {
        self.view.addSubview(navigationBar)
        navigationBar.autoPinEdge(toSuperviewSafeArea: .top)
        navigationBar.autoPinEdge(toSuperviewEdge: .right)
        navigationBar.autoPinEdge(toSuperviewEdge: .left)
        let navigationItem = UINavigationItem(title: "")
        navigationBar.setItems([navigationItem], animated: true)
    }
    
    func updateNavigationBarTitle(with title: String) {
        self.navigationBar.topItem?.title = title
    }
    
    func showAlert(title : String , Message : String) {
        let alert = UIAlertController(title: title, message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath) as! CountryTableViewCell
        cell.bind(viewModel.countryModel?.details[indexPath.row])
        return cell
    }
}
