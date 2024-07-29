//
//  UniversityDataModel.swift
//  UniversitiesListDemoApp
//
//  Created by Kondamoori, Krishna on 28/07/2024.
//

import Foundation
import Realm
import RealmSwift

/// UniversityDataModel
class UniversityDataModel : Object, Decodable {
    @Persisted var alpha_two_code: String = ""
    @Persisted var web_pages = RealmSwift.List<String>()
    @Persisted var country: String = ""
    @Persisted var domains = RealmSwift.List<String>()
    @Persisted var name: String = ""
    @Persisted var stateProvince: String = ""
    @Persisted var id: ObjectId = ObjectId.generate()
    
    // MARK: - Coding keys
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case alpha_two_code = "alpha_two_code"
        case web_pages = "web_pages"
        case country = "country"
        case domains = "domains"
        case name = "name"
        case stateProvince = "state-province"
    }
    
    // MARK: - Decoder - init
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        domains = try values.decodeIfPresent(List<String>.self, forKey: .domains) ?? List<String>()
        stateProvince = try values.decodeIfPresent(String.self, forKey: .stateProvince) ?? ""
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        web_pages = try values.decodeIfPresent(List<String>.self, forKey: .web_pages) ?? List<String>()
        country = try values.decodeIfPresent(String.self, forKey: .country) ?? ""
        alpha_two_code = try values.decodeIfPresent(String.self, forKey: .alpha_two_code) ?? ""
        super.init()
    }
    
    required override init() {
        super.init()
    }
    
    
    // MARK: - Database
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
