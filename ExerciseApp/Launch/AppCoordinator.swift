//
//  AppCoordinator.swift
//  ExerciseApp
//
//  Created by Pranav V K on 10/07/20.
//  Copyright © 2020 Pranav V K. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var window: UIWindow
    let navigationController: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func start() {
        let viewConroller = MainViewController()
        viewConroller.modalPresentationStyle = .fullScreen
        navigationController.pushViewController(viewConroller, animated: false)
    }
}
