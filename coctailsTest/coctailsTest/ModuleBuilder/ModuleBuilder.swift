//
//  ModuleBuilder.swift
//  coctailsTest
//
//  Created by Anatoliy on 28.03.2022.
//

import UIKit

protocol ModuleBuilderProtocol {
    func createMainModule() -> UIViewController
}

class ModuleBuilder: ModuleBuilderProtocol {
    
    let networkManager = NetworkManager()
    
    func createMainModule() -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter(view: view, networkManager: networkManager)
        view.presenter = presenter
        return view
    }
}
