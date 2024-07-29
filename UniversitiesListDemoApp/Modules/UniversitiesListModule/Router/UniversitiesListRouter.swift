//
//  UniversitiesListRouter.swift
//  UniversitiesListDemoApp
//
//  Created by Kondamoori, Krishna on 28/07/2024.
//

import Foundation
import UIKit

final class UniversitiesListRouter: UniversitiesListModule.PresenterToRouterProtocol {
        
    static func startModule() -> UniversitiesListViewController {
        let listView = UniversitiesListViewController()
        let presenter: UniversitiesListModule.ViewToPresenterProtocol & UniversitiesListModule.InteractorToPresenterProtocol = UniversitiesListPresenter()
        let interactor: UniversitiesListModule.PresenterToInteractorProtocol = UniversitiesListInteractor(requestManger: UniversitiesRequestManager(requestManager: NetworkRequestManager()))
        let router: UniversitiesListModule.PresenterToRouterProtocol = UniversitiesListRouter()
        
        listView.presnetor = presenter
        presenter.view = listView
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return listView
    }
    
    func pushToUniversityDetailsScreen(navigationController: UINavigationController, universityDetails: UniversityDetailsModel, delegate: UniversityDetailsModule.UniversityDetailsPresenterDelegate) {
        let detailsViewController = UniversityDetailsRouter.startModule(university: universityDetails, delegate: delegate)
        
        navigationController.pushViewController(detailsViewController, animated: true)
    }
    
}
