//
//  UniversityDetailsRouter.swift
//  UniversitiesListDemoApp
//
//  Created by Kondamoori, Krishna on 28/07/2024.
//

import Foundation
import UIKit

final class UniversityDetailsRouter: UniversityDetailsModule.PresenterToRouterProtocol {
    
    // MARK: - Router functions
    
    static func startModule(university: UniversityDetailsModel, delegate: UniversityDetailsModule.UniversityDetailsPresenterDelegate) -> UniversityDetailsViewController {
        let detailsView = UniversityDetailsViewController(universityDetails: university)
        let presenter = UniversityDetailsPresenter()
        presenter.delegate = delegate
        let interactor: UniversityDetailsModule.PresenterToInteractorProtocol = UniversityDetailsInteractor()
        let router: UniversityDetailsModule.PresenterToRouterProtocol = UniversityDetailsRouter()
        detailsView.presnetor = presenter
        presenter.view = detailsView
        presenter.router = router
        presenter.delegate = delegate
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return detailsView
    }
    
    func popToUniversitiesList(navigationController: UINavigationController) {
        navigationController.popViewController(animated: true)
    }
}
