//
//  UniversitiesListCell.swift
//  UniversitiesListDemoApp
//
//  Created by Kondamoori, Krishna on 28/07/2024.
//

import UIKit

class UniversitiesListCell: UITableViewCell {
    
    // MARK: - Constants
    
    static let cellIdentifier = "UniversityListCell"

    private enum Constants {
        static let containerSpacing: CGFloat = 10
    }
    
    // MARK: - Private properties
    
    private let container: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.containerSpacing
        return stackView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let stateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: Self.cellIdentifier)
        accessoryType = .disclosureIndicator
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK - Internal functions
    
    func configureData(data: UniversityDataModel) {
        nameLabel.text = data.name
        stateLabel.text = data.stateProvince
    }
    
    // MARK: - Private functions
    
    private func setupLayout() {
        contentView.addSubview(container)
        container.addArrangedSubview(nameLabel)
        container.addArrangedSubview(stateLabel)
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.containerSpacing),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.containerSpacing),
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.containerSpacing),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.containerSpacing)
        ])
    }
}
