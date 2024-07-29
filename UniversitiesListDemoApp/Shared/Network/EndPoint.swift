//
//  EndPoint.swift
//  UniversitiesListModule
//
//  Created by Kondamoori, Krishna on 28/07/2024.
//

import Foundation

// Defines different HTTP request methods
enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case patch  = "PATCH"
    case delete = "DELETE"
}

/// enum to represent the different types of HTTP ContentTypes
enum ContentType: String {
    case JSON = "application/json"
}

protocol EndPoint {
    
    /// - Returns: RELATIVE path of the endpoint
    var path: String { get }
    
    /// - Returns: The method to be used
    var method: HTTPMethod { get }
    
    /// - Returns: The body (or content) to be used in the request
    var body: Data? { get }
    
    /// - Returns: The headers to be send in the request
    var headers: [String: String]? { get }

    /// - Returns: The Content type, if not set the JSON is used is used
    var contentType: ContentType { get }
    
    var queryItems: [URLQueryItem] { get }
}
