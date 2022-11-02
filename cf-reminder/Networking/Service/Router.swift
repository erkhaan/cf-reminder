//
//  Router.swift
//  cf-reminder
//
//  Created by Erkhaan  on 26.10.2022.
//

import Foundation

class Router<Endpoint: EndpointType>: NetworkRouter {
    private var task: URLSessionTask?
    func request(_ route: Endpoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(
                with: request,
                completionHandler: { data, response, error in
                    completion(data, response, error)})
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    
    fileprivate func buildRequest(from route: Endpoint) throws -> URLRequest {
        var request = URLRequest(
            url: route.baseURL.appending(component: route.path),
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 10.0)
        request.httpMethod = route.httpMethod.rawValue
        switch route.task {
        case .request:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return request
    }
    
    func cancel() {
        self.task?.cancel()
    }
}
