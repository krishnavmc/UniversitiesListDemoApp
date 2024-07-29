//
//  GCD.swift
//  UniversitiesListDemoApp
//
//  Created by Kondamoori, Krishna on 28/07/2024.
//

import Foundation

enum GCD {
    /// To run operation on main thread
    static func runOnMainThread(closure: @escaping () -> Void) {
        DispatchQueue.main.async {
            closure()
        }
    }
}
