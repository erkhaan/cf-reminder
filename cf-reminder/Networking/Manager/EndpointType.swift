//
//  EndpointType.swift
//  cf-reminder
//
//  Created by Erkhaan  on 25.10.2022.
//

import Foundation

protocol EndpointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
