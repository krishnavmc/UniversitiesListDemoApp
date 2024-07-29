//
//  LocalizedTranslator.swift
//  UniversitiesListDemoApp
//
//  Created by Kondamoori, Krishna on 28/07/2024.
//

import Foundation

/// Type which used access localised keys.
enum LocalizedTranslator {
    
    enum AlertTranslation {
        static let alertTitleSuccess = NSLocalizedString("success", comment: "")
        static let alertTitleFail = NSLocalizedString("failed", comment: "")
        static let alertOkayButton = NSLocalizedString("ok", comment: "")
        static let alertCancelButton = NSLocalizedString("cancel", comment: "")
    }
    
    enum UniversitiesListScreen {
        static let viewTitle = NSLocalizedString("universitiesListViewTitle", comment: "")
        static let errorMessageFetchUniversities = NSLocalizedString("errorMessageFetchUniversities", comment: "")

    }
}
