//
//  MainPresenter.swift
//  coctailsTest
//
//  Created by Anatoliy on 28.03.2022.
//

import Foundation

class MainPresenter {
    
    weak var view: MainViewProtocol?
    private let networkManager: CoctailsNetworkProtocol!
    
    required init(view: MainViewProtocol, networkManager: CoctailsNetworkProtocol) {
        self.view = view
        self.networkManager = networkManager
    }
}

extension MainPresenter: MainPresenterProtocol {
    func viewDidLoad() {
        networkManager.requestCoctails { result in
            switch result {
                
            case .success(let response):
                print(response.items.count)
                
                for i in response.items {
                    print(i.name)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

    
    
}
