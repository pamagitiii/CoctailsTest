//
//  NetworkSeviceProtocols.swift
//  coctailsTest
//
//  Created by Anatoliy on 29.03.2022.
//

import Foundation

protocol CoctailsNetworkProtocol {
    //func download()
    func requestCoctails(completion: @escaping (Result<CoctailsResponse, Error>) -> Void)
}

enum CoctailsRequestParams {
    case noAlco
    
    var parameters: [String: String] {
        switch self {
        case .noAlco:
            return ["a": "Non_Alcoholic"]
        }
    }
}


