//
//  UniversityDetailsPresenter.swift
//  UniversitiesListDemoApp
//
//  Created by Kondamoori, Krishna on 28/07/2024.
//

import Foundation
import UIKit

final class UniversityDetailsPresenter: UniversityDetailsModule.ViewToPresenterProtocol, UniversityDetailsModule.InteractorToPresenterProtocol {
    
    // MARK: - Internal properties
    
    weak var delegate: UniversityDetailsModule.UniversityDetailsPresenterDelegate?
    
    var view: UniversityDetailsModule.PresenterToViewProtocol?
    
    var interactor: UniversityDetailsModule.PresenterToInteractorProtocol?
    
    var router: UniversityDetailsModule.PresenterToRouterProtocol?
    
    // MARK: - Internal functions
        
    func didPressRefreshButton(navigationController: UINavigationController) {
        router?.popToUniversitiesList(navigationController: navigationController)
        delegate?.didClickRefreshButton()
    }
}
