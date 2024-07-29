//
//  UniversityDetailsViewController.swift
//  UniversitiesListDemoApp
//
//  Created by Kondamoori, Krishna on 28/07/2024.
//

import Foundation
import UIKit

final class UniversityDetailsViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let containerSpacing: CGFloat = 10
        static let refreshButtonTitle = "Refresh"
    }
    
    // MARK: - Internal properties
    var presnetor: UniversityDetailsModule.ViewToPresenterProtocol?

    // MARK: - Private properties
    
    private let universityDetails: UniversityDetailsModel
    private let container: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = Constants.containerSpacing
        return stackView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stateProvinceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let alphaTwoCodeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let webPagesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let domainsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Init
    
    init(universityDetails: UniversityDetailsModel) {
        self.universityDetails = universityDetails
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        addRefreshButton()
    }
    
    // MARK: - Private functions
    
    private func configureUI() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(container)
        
        container.addArrangedSubview(nameLabel)
        container.addArrangedSubview(stateProvinceLabel)
        container.addArrangedSubview(alphaTwoCodeLabel)
        container.addArrangedSubview(countryLabel)
        container.addArrangedSubview(webPagesLabel)
        container.addArrangedSubview(domainsLabel)

        // Add constraints
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.containerSpacing),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.containerSpacing),
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.containerSpacing),
            container.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            view.heightAnchor.constraint(equalToConstant: view.frame.height),
            view.widthAnchor.constraint(equalToConstant: view.frame.width)
        ])
        
        nameLabel.text = universityDetails.name
        stateProvinceLabel.text = universityDetails.stateProvince
        alphaTwoCodeLabel.text = universityDetails.alpha_two_code
        countryLabel.text = universityDetails.country
        webPagesLabel.text = universityDetails.web_pages.joined(separator: ",")
        domainsLabel.text = universityDetails.domains?.joined(separator: ",")
    }
    
    func addRefreshButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.refreshButtonTitle, style: .plain, target: self, action: #selector(didPressRefresh))
    }
    
    @objc func didPressRefresh() {
        guard let navigationController = navigationController else {
            assertionFailure("navigationController should present")
            return
        }
        
        presnetor?.didPressRefreshButton(navigationController: navigationController)
    }
}

// MARK: - Extension PresenterToViewProtocol

extension UniversityDetailsViewController: UniversityDetailsModule.PresenterToViewProtocol { }


