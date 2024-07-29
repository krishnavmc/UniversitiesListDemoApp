//
//  UniversitiesListPresenter.swift
//  UniversitiesListDemoApp
//
//  Created by Kondamoori, Krishna on 28/07/2024.
//

import Foundation
import UIKit

final class UniversitiesListPresenter: UniversitiesListModule.ViewToPresenterProtocol {
    
    // MARK: - Internal properties
    
    var view: UniversitiesListModule.PresenterToViewProtocol?
    
    var interactor: UniversitiesListModule.PresenterToInteractorProtocol?
    
    var router: UniversitiesListModule.PresenterToRouterProtocol?
    
    // MARK: - Internal functions
    
    func fetchUniversitiesList() {
        interactor?.fetchUniversitiesList()
    }
    
    func showDetails(navigationController: UINavigationController, university: UniversityDetailsModel) {
        router?.pushToUniversityDetailsScreen(navigationController:navigationController, universityDetails: university,  delegate: self)
    }
}


// MARK: - InteractorToPresenterProtocol

extension UniversitiesListPresenter: UniversitiesListModule.InteractorToPresenterProtocol {
    
    func fetchUniversitiesSuccess(list: [UniversityDataModel]) {
        view?.presentUniversitiesList(list: list)
    }
    
    func fetchUniversitiesFailed() {
        view?.presentError()
    }
}

// MARK: - UniversityDetailsPresenterDelegate delegate

extension UniversitiesListPresenter: UniversityDetailsModule.UniversityDetailsPresenterDelegate {
    func didClickRefreshButton() {
        interactor?.fetchUniversitiesList()
    }
}
