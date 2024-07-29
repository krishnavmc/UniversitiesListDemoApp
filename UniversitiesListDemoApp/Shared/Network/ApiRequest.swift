//
//  ApiRequest.swift
//  UniversitiesListModule
//
//  Created by Kondamoori, Krishna on 28/07/2024.
//

import Foundation

/// Type to support different app environments.
enum Environment: String {
    case production = "http://universities.hipolabs.com/"
    case test = "http://test.universities.hipolabs.com/"
    case acceptance = "http://accp.universities.hipolabs.com/"
}

struct ApiRequest {
    
    // MARK: - Internal Properties

    let path: String
    let httpMethod: HTTPMethod
    let body: Data?
    let headers: [String: String]?
    let environment: Environment
    let urlQueryItems: [URLQueryItem]
  
    var request: URLRequest? {
        guard let url = urlComponents?.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body
        if  let headers = headers {
            for(headerField, headerValue) in headers {
                request.setValue(headerValue, forHTTPHeaderField: headerField)
            }
        }
        return request
    }
    
    // MARK: - Private Properties

    private var urlComponents: URLComponents? {
        let base: String = environment.rawValue
        var component = URLComponents(string: base)
        component?.path = path
        component?.queryItems = urlQueryItems
        return component
    }
    
    // MARK: - Life cycle

    init(endPoint: EndPoint, environment: Environment = .production) {
        self.httpMethod = endPoint.method
        self.path = endPoint.path
        self.body = endPoint.body
        self.headers = endPoint.headers
        self.environment = environment
        self.urlQueryItems = endPoint.queryItems
    }
}
