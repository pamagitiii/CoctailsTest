//
//  NetworkManager.swift
//  coctailsTest
//
//  Created by Anatoliy on 28.03.2022.
//

import Foundation
import Alamofire

class NetworkManager {

    func baseRequest<T: Decodable>(url: URL?, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = url else {
            completion(.failure(NetworkError.wrongUrl))
            return
        }
        
        AF.request(url).validate().responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(_):
                completion(.failure(NetworkError.dataIsNil))
            }
        }
    }
}

extension NetworkManager: CoctailsNetworkProtocol {
    func requestCoctails(completion: @escaping (Result<CoctailsResponse, Error>) -> Void) {
        let url = URLFactory.coctails(params: .noAlco)
        baseRequest(url: url, completion: completion)
    }
}

enum NetworkError: Error, LocalizedError {
    case wrongUrl
    case dataIsNil
    
    var errorDescription: String? {
        switch self {
        case .wrongUrl:
            return "Wrong URL"
        case .dataIsNil:
            return "Can't get data from server"
        }
}
}
