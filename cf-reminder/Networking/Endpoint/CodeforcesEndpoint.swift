//
//  CodeforcesEndpoint.swift
//  cf-reminder
//
//  Created by Erkhaan  on 03.11.2022.
//

import Foundation

public enum CodeforcesApi {
    case contestList
}

extension CodeforcesApi: EndpointType {
    var baseURL: URL {
        guard let url = URL(string: "https://codeforces.com/api/") else {
            fatalError("wrong url")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .contestList:
            return "contest.list"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .contestList:
            return .request
        }
    }
}
