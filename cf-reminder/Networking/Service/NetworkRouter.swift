//
//  NetworkRouter.swift
//  cf-reminder
//
//  Created by Erkhaan  on 26.10.2022.
//

import Foundation

public typealias NetworkRouterCompletion = (
    _ data: Data?,
    _ response: URLResponse?,
    _ error: Error?) -> Void

protocol NetworkRouter: AnyObject {
    associatedtype Endpoint: EndpointType
    func request(_ route: Endpoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
