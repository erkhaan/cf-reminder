//
//  NetworkManager.swift
//  cf-reminder
//
//  Created by Erkhaan  on 03.11.2022.
//

import Foundation

enum NetworkResponse: String {
    case success
    case authError = "You need to be authenticated"
    case badRequest = "Bad request"
    case failed = "Network request failed"
    case noData = "Response returned no data"
    case unableToDecode = "Response not decodable"
}

enum Result<String> {
    case success
    case failure(String)
}

struct NetworkManager {
    private let router = Router<CodeforcesApi>()
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    func getContests(completion: @escaping (_ contest: [Contest]?, _ error: String?) -> ()) {
        router.request(.contestList) { data, response, error in
            if error != nil {
                completion(nil, "Check connection")
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(Response.self, from: responseData)
                        completion(apiResponse.result, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
}
