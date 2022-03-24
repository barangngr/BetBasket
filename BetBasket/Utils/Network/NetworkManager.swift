//
//  NetworkManager.swift
//  BetBasket
//
//  Created by Baran Gungor on 23.03.2022.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    // MARK: Properties
    typealias parameters = [String: Any]?
    static var shared: NetworkManager = NetworkManager()
    private var alamofireManager = Session()
    private let baseURL = "https://api.the-odds-api.com"
    private let APIKey = "0f563e120fb5f96f277f588b841708df"
    
    // MARK: Initiliaze
    private init() {}
    
    // MARK: Functions
    func sendRequest<T: Codable>(model: BaseAPI, parameters: parameters = nil, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let urlComp = NSURLComponents(string: baseURL + model.path) else {
            completion(.failure(GeneralError.invalidURL))
            return
        }
                
        guard let url = urlComp.url else {
            completion(.failure(GeneralError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = model.method.rawValue
        
        var param: Parameters = ["apiKey": APIKey]
        if let parameters = parameters {
            parameters.forEach { key, value in
                param.updateValue(value, forKey: key)
            }
        }
        
        AF.request(url, method: model.method, parameters: param).responseJSON { response in
            
            if let data = response.data {
                do {
                    guard let statusCode = response.response?.statusCode, (200...299).contains(statusCode) else {
                        let userResponse = try JSONDecoder().decode(BaseErrorModel.self, from: data)
                        completion(.failure(GeneralError.unexpected(response.response!.statusCode, userResponse.message ?? "")))
                        return
                    }
                    
                    let userResponse = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(userResponse))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        
    }
    
}
