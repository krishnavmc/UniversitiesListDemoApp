//
//  UniversitiesRequestManager.swift
//  UniversitiesListDemoApp
//
//  Created by Kondamoori, Krishna on 28/07/2024.
//

import Foundation

protocol UniversitiesRequestManagerProtocol {
    func fetchData(completion: @escaping (Result<[UniversityDataModel], Error>) -> Void)
}

/// Request manager to fetch universities data
struct UniversitiesRequestManager: UniversitiesRequestManagerProtocol {
    
    // MARK: - Private properties
    
    private let requestManager: NetworkRequestManagerInterface
            
    // MARK: - Init
    
    init(requestManager: NetworkRequestManagerInterface) {
        self.requestManager = requestManager
    }
    
    // MARK: - Internal functions
    
    /// Function to fetch data form CSVData end point.
    /// - Returns: array of strings.
    func fetchData(completion: @escaping (Result<[UniversityDataModel], Error>) -> Void) {
        let apiRequest = ApiRequest(endPoint: UniversitiesListEndPoint.listOfUniversities)
        guard let urlRequest = apiRequest.request else {
            completion(.failure(ApiError.requestError))
            return
        }
        
        requestManager.performRequest(request: urlRequest) { (result: Result<[UniversityDataModel], Error>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

/// CSVData end point, which contains all details to make URLRequest.
enum UniversitiesListEndPoint: EndPoint {

    private enum Constants {
        static let countryValue = "United Arab Emirates"
        static let countryValueKey = "country"
    }
    
    case listOfUniversities
    
    var path: String {
        switch self {
        case .listOfUniversities:
            return "/search"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .listOfUniversities:
            return .get
        }
    }
    
    var body: Data? {
        return nil
    }
    
    var contentType: ContentType {
        return .JSON
    }
    
    var headers: [String: String]? {
        var newHeaders = [String: String]()
        newHeaders["Content-Type"] = contentType.rawValue
        return newHeaders
    }
    
    var queryItems: [URLQueryItem] {
        return [URLQueryItem(name: Constants.countryValueKey, value: Constants.countryValue)]
    }
    
}
