//
//  MainProtocols.swift
//  coctailsTest
//
//  Created by Anatoliy on 28.03.2022.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func didLoadData()
    func updateItems(at index: Int)
}

protocol MainPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, networkManager: CoctailsNetworkProtocol)
    var coctails: [String] { get }
    var selected: [String] { get }
    func viewDidLoad()
    func didSelectCellatIndex(_ index: Int)
}
