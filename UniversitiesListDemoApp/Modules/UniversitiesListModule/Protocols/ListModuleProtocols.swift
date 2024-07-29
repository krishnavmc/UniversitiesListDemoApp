//
//  ListModuleProtocols.swift
//  UniversitiesListDemoApp
//
//  Created by Kondamoori, Krishna on 28/07/2024.
//

import Foundation
import UIKit

enum UniversitiesListModule {
    
    protocol ViewToPresenterProtocol: AnyObject {
        var view: PresenterToViewProtocol? {get set}
        var interactor: PresenterToInteractorProtocol? {get set}
        var router: PresenterToRouterProtocol? {get set}
        func fetchUniversitiesList()
        func showDetails(navigationController:UINavigationController, university: UniversityDetailsModel)
    }
    
    protocol PresenterToViewProtocol: AnyObject {
        func presentUniversitiesList(list: [UniversityDataModel])
        func presentError()
    }
    
    protocol PresenterToRouterProtocol: AnyObject {
        static func startModule() -> UniversitiesListViewController
        func pushToUniversityDetailsScreen(navigationController:UINavigationController, universityDetails: UniversityDetailsModel, delegate: UniversityDetailsModule.UniversityDetailsPresenterDelegate)
    }
    
    protocol PresenterToInteractorProtocol: AnyObject {
        var presenter: InteractorToPresenterProtocol? {get set}
        func fetchUniversitiesList()
    }
    
    protocol InteractorToPresenterProtocol: AnyObject {
        func fetchUniversitiesSuccess(list: [UniversityDataModel])
        func fetchUniversitiesFailed()
    }
}
