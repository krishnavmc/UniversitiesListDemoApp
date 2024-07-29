//
//  UniversityDetailModel.swift
//  UniversitiesListDemoApp
//
//  Created by Kondamoori, Krishna on 28/07/2024.
//

import Foundation

/// Details of university data
/// Considering this as separate model as to avoid dependency with other module (list module).
struct UniversityDetailsModel {
    let alpha_two_code: String?
    let web_pages: [String]
    let country: String?
    let domains: [String]?
    let name: String?
    let stateProvince: String?
}
