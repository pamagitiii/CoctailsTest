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
    var coctails: [String] = []
    var selected: [String] = [] {
        didSet {
            print(selected)
        }
    }
    
    required init(view: MainViewProtocol, networkManager: CoctailsNetworkProtocol) {
        self.view = view
        self.networkManager = networkManager
    }
}

extension MainPresenter: MainPresenterProtocol {
    func didSelectCellatIndex(_ index: Int) {
        let text = coctails[index]
        
        if selected.contains(text) {
            selected = selected.filter{$0 != text}
        } else {
            selected.append(text)
        }
       // coctails[index].isChosen = true
        //view?.didLoadData()
        view?.updateItems(at: index)
    }
    
    func viewDidLoad() {
        networkManager.requestCoctails { [weak self] result in
            switch result {
            case .success(let response):
                self?.coctails = response.items.map { $0.name }
                self?.view?.didLoadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
