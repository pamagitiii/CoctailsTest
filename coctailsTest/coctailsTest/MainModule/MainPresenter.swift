//
//  MainPresenter.swift
//  coctailsTest
//
//  Created by Anatoliy on 28.03.2022.
//

import Foundation

class MainPresenter {
    
    //MARK: - properties
    weak var view: MainViewProtocol?
    private let networkManager: CoctailsNetworkProtocol!
    var coctails: [String] = []
    var selected: [String] = [] {
        didSet {
            print(selected)
        }
    }
    //MARK: - init
    required init(view: MainViewProtocol, networkManager: CoctailsNetworkProtocol) {
        self.view = view
        self.networkManager = networkManager
    }
}

//MARK: - presenter protocol
extension MainPresenter: MainPresenterProtocol {
    func searchTextDidChange(_ text: String?) {
        guard let text = text else { return }
        
        if text.isValid() {
            selected = coctails.filter { $0.lowercased().contains(text.lowercased()) }
            view?.didLoadData()
        } else {
            selected = []
            view?.didLoadData()
        }
    }
    
    func didSelectCellatIndex(_ index: Int) {
        let text = coctails[index]
        
        if selected.contains(text) {
            selected = selected.filter{$0 != text}
        } else {
            selected.append(text)
        }
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
