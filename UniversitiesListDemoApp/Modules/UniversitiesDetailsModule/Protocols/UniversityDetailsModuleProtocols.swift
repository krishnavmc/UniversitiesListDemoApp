//
//  UniversityDetailsModuleProtocols.swift
//  UniversitiesListDemoApp
//
//  Created by Kondamoori, Krishna on 28/07/2024.
//

import Foundation
import UIKit

enum UniversityDetailsModule {
    
    protocol ViewToPresenterProtocol: AnyObject {
        
        var view: PresenterToViewProtocol? {get set}
        var interactor: PresenterToInteractorProtocol? {get set}
        var router: PresenterToRouterProtocol? {get set}
        func didPressRefreshButton(navigationController: UINavigationController)
    }
    
    protocol PresenterToViewProtocol: AnyObject {}
    
    protocol PresenterToRouterProtocol: AnyObject {
        static func startModule(university: UniversityDetailsModel, delegate: UniversityDetailsModule.UniversityDetailsPresenterDelegate)-> UniversityDetailsViewController
        func popToUniversitiesList(navigationController:UINavigationController)
    }
    
    protocol PresenterToInteractorProtocol: AnyObject {
        var presenter:InteractorToPresenterProtocol? {get set}
    }
    
    protocol InteractorToPresenterProtocol: AnyObject { }
    
    protocol UniversityDetailsPresenterDelegate: AnyObject {
        func didClickRefreshButton()
    }
}
