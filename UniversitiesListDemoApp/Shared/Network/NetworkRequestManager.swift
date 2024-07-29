//
//  NetworkRequestManager.swift
//  UniversitiesListModule
//
//  Created by Kondamoori, Krishna on 28/07/2024.
//

import Foundation

/// Network request manager interface.
protocol NetworkRequestManagerInterface {
    func performRequest<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void)
}

/// Network manager which responsible for the perform request.
class NetworkRequestManager: NetworkRequestManagerInterface {
    
    /// Function to perform request
    /// - Parameter request: instance of URL Request.
    /// - Returns: returns the parsed data by Type inferring if no error.
    func performRequest<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        
        // Check the network connection before make request
        guard Reachability.isConnectedToNetwork() else  {
            completion(.failure(ApiError.noInternet))
            return
        }
        
        // URLSession Task
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self else {
                completion(.failure(ApiError.requestError))
                return
            }
            
            if let error {
                completion(.failure(error))
            }
            
            guard let data, let response else {
                completion(.failure(ApiError.invalidResponse))
                return
            }
            
            do {
                let data = try self.parseHttpResponse(response: (data, response))
                let jsonData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(jsonData))
            } catch {
                completion(.failure(ApiError.invalidResponse))
            }
        }.resume()
    }
    
    /// Function to parse HTTP Response from perform request of NetworkRequestManager.
    /// - Parameter response: response object with (Data, URLResponse)
    /// - Returns: instance of Data if httpResponse.statusCode 200..<300.
    func parseHttpResponse(response: (data: Data, response: URLResponse)) throws -> Data {
        guard let httpResponse = response.response as? HTTPURLResponse else {
            return response.data
        }
        
        switch httpResponse.statusCode {
        case 200..<300:
            return response.data
        case 400:
            throw ApiError.requestError
        case 401:
            throw ApiError.unAuthorized
        case 403:
            throw ApiError.forbidden
        case 404:
            throw ApiError.notFound
        default:
            throw ApiError.unknownError(httpResponse: httpResponse, data: response.data)
        }
    }
}
