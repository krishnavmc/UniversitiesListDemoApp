//
//  ApiError.swift
//  UniversitiesListModule
//
//  Created by Kondamoori, Krishna on 28/07/2024.
//

import Foundation

/// Custom Error type
enum ApiError: Error, LocalizedError, Equatable {
    case requestError
    case invalidResponse
    case parsingError
    case unAuthorized
    case forbidden
    case notFound
    case noInternet
    case unknownError(httpResponse: HTTPURLResponse, data: Data)
}
