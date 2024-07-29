//
//  APIRequestTests.swift
//  UniversitiesListDemoAppTests
//
//  Created by Kondamoori, Krishna on 29/07/2024.
//

import XCTest
@testable import UniversitiesListDemoApp

final class ApiRequestTests: XCTestCase {

    var sut: ApiRequest!
    
    override func setUp() {
        super.setUp()
        sut = ApiRequest(endPoint: MockEndPoint(), environment: .acceptance)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testApiRequestInitialisation() {
        // Assert
        XCTAssertEqual(sut.path, "/testPath")
        XCTAssertEqual(sut.httpMethod, .get)
        XCTAssertEqual(sut.environment, .acceptance)
        XCTAssertEqual(sut.body, "test".data(using: .utf8))
        XCTAssertEqual(sut.headers, ["header": "test"])
    }
    
    func testUrlRequestCreationFromEndPoint() throws {
        // Assert
        let request = try XCTUnwrap(sut.request)
        let requestMethod = try XCTUnwrap(request.httpMethod)
        let requestBody = try XCTUnwrap(request.httpBody)
        let requestUrl = try XCTUnwrap(request.url)

        XCTAssertEqual(String(decoding: requestBody, as: UTF8.self), "test")
        XCTAssertEqual(requestMethod, HTTPMethod.get.rawValue)
        XCTAssertEqual(requestUrl, URL(string: "http://accp.universities.hipolabs.com/testPath?"))

    }

}


struct MockEndPoint: EndPoint {
    var path: String {
        "/testPath"
    }
    
    var method: UniversitiesListDemoApp.HTTPMethod {
        .get
    }
    
    var body: Data? {
        "test".data(using: .utf8)
    }
    
    var headers: [String : String]? {
        ["header": "test"]
    }
    
    var contentType: UniversitiesListDemoApp.ContentType {
        .JSON
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
}
