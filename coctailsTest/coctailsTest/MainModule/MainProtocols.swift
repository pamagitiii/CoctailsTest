//
//  MainProtocols.swift
//  coctailsTest
//
//  Created by Anatoliy on 28.03.2022.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    
}

protocol MainPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, networkManager: CoctailsNetworkProtocol)
    
    func viewDidLoad()
}
