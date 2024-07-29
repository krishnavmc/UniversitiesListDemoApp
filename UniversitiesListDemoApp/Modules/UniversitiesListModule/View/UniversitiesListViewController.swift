//
//  UniversitiesListViewController.swift
//  UniversitiesListDemoApp
//
//  Created by Kondamoori, Krishna on 28/07/2024.
//

import Foundation
import UIKit

/// View Controller to show List of universities.
final class UniversitiesListViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let viewTitle = LocalizedTranslator.UniversitiesListScreen.viewTitle
        static let numberOfSections = 1
        static let alertTitleFail = LocalizedTranslator.AlertTranslation.alertTitleFail
        static let failureMessage = LocalizedTranslator.UniversitiesListScreen.errorMessageFetchUniversities
        static let alertOkayButtonTitle = LocalizedTranslator.AlertTranslation.alertOkayButton
        static let alertCancelButtonTitle = LocalizedTranslator.AlertTranslation.alertCancelButton
    }
    
    // MARK: - Internal properties
    
    var presnetor: UniversitiesListModule.ViewToPresenterProtocol?
    let tableView: UITableView
    
    // MARK: - Private properties
    
    private var dataSource: [UniversityDataModel] = [] {
        didSet {
            reloadData()
        }
    }
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlDidRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    
    // MARK: - Init
    
    init() {
        tableView = UITableView()
        super.init(nibName: nil, bundle: nil)
        tableView.register(UniversitiesListCell.self, forCellReuseIdentifier: UniversitiesListCell.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.refreshControl = refreshControl
        title = Constants.viewTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        tableView.reloadData()
        ProgressIndicator.showProgressIndicator(in: view)
        presnetor?.fetchUniversitiesList()
    }
    
    // MARK: - Private functions
    
    private func setupConstraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    @objc private func refreshControlDidRefresh() {
        presnetor?.fetchUniversitiesList()
    }
    
    private func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - Extension - UITableViewDataSource

extension UniversitiesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UniversitiesListCell.cellIdentifier, for: indexPath) as? UniversitiesListCell else {
            return UITableViewCell()
        }
        
        let university = dataSource[indexPath.row]
        cell.configureData(data: university)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Constants.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
}

// MARK: - Extension - UITableViewDelegate

extension UniversitiesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigationController = navigationController else {
            assertionFailure("Navigation controller should not be nil")
            return
        }
        let universityAtIndex = dataSource[indexPath.row]
        
        presnetor?.showDetails(navigationController: navigationController, university: UniversityDetailsModel(alpha_two_code: universityAtIndex.alpha_two_code, web_pages: universityAtIndex.web_pages.sorted(), country: universityAtIndex.country, domains: universityAtIndex.domains.sorted(), name: universityAtIndex.name, stateProvince: universityAtIndex.stateProvince))
    }
}

// MARK: - Extension - PresenterToViewProtocol

extension UniversitiesListViewController: UniversitiesListModule.PresenterToViewProtocol, AlertService {
    
    func presentUniversitiesList(list: [UniversityDataModel]) {
        ProgressIndicator.hideProgressIndicator(view: view)
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
        dataSource = list
    }
    
    func presentError() {
        ProgressIndicator.hideProgressIndicator(view: view)
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
        showAlert(titleStr: Constants.alertTitleFail, messageStr: Constants.failureMessage, okButtonTitle: Constants.alertOkayButtonTitle, cancelButtonTitle: Constants.alertCancelButtonTitle, response: nil)
    }
}
