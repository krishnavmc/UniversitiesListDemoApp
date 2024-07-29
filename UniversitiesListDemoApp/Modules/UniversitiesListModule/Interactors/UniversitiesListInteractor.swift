//
//  UniversitiesListInteractor.swift
//  UniversitiesListDemoApp
//
//  Created by Kondamoori, Krishna on 28/07/2024.
//

import Foundation

final class UniversitiesListInteractor: UniversitiesListModule.PresenterToInteractorProtocol {
    
    var presenter: UniversitiesListModule.InteractorToPresenterProtocol?
    var requestManger: UniversitiesRequestManagerProtocol
    var databaseManager = DatabaseManager.shared
    
    init(presenter: UniversitiesListModule.InteractorToPresenterProtocol? = nil, requestManger: UniversitiesRequestManagerProtocol) {
        self.presenter = presenter
        self.requestManger = requestManger
    }
    
    func fetchUniversitiesList() {
        requestManger.fetchData {[weak self] result in
            GCD.runOnMainThread {
            switch result {
                case .success(let data):
                    // Check the response and use database
                    guard !data.isEmpty else {
                        if let data = self?.fetchFromDataBaseIfPresent(), !data.isEmpty {
                            self?.presenter?.fetchUniversitiesSuccess(list: data)
                        }
                        return
                    }
                
                    self?.updateDataBase(list: data)
                    self?.presenter?.fetchUniversitiesSuccess(list: data)
                case .failure:
                    guard let data = self?.fetchFromDataBaseIfPresent() else {
                        self?.presenter?.fetchUniversitiesFailed()
                        return
                    }
                
                    self?.presenter?.fetchUniversitiesSuccess(list: data)
                }
            }
        }
    }
    
    func updateDataBase(list: [UniversityDataModel]) {
        databaseManager.deleteAll(object: UniversityDataModel.self)
        databaseManager.saveObjects(objects: list)
    }
    
    func fetchFromDataBaseIfPresent() -> [UniversityDataModel] {
        let (data, contains) = databaseManager.fetchObjects(object: UniversityDataModel.self)
        if contains {
            return data
        } else {
            return []
        }
    }
}


