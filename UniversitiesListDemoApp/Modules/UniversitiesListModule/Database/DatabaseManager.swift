//
//  DatabaseManager.swift
//  UniversitiesListDemoApp
//
//  Created by Kondamoori, Krishna on 28/07/2024.
//

import Foundation
import RealmSwift

/// Database manager
final class DatabaseManager {
    
    // MARK: - Private properties
    
    static let shared = DatabaseManager()
    private let database: Realm?
    
    // MARK: - Init
    
    private init() {
        do {
            database = try Realm()
        } catch {
            database = nil
            assertionFailure("Unable to create database")
        }
    }
    
    /// Save Object
    /// - Parameter objects: objects need to be saved
    func saveObjects<T:Object>(objects: [T]) {
        do {
            try database?.write {
                database?.add(objects, update: .modified)
            }
        } catch{
            assertionFailure("An error occurred while saving the data: \(error)")
        }
    }
    
    /// Fetch Objects
    /// - Parameter object: object type to be fetched
    /// - Returns: Returns list of objects along with bool to indicate it present or not
    func fetchObjects<T:Object>(object:T.Type) -> (data: [T], contains: Bool) {
        let boolValue:Bool = true
        guard let objects = database?.objects(T.self), !objects.isEmpty else {
            return ([], false)
        }
        
        return (Array(objects), boolValue)
    }
    
    /// Delete objects from memory
    /// - Parameter object: Type of object to be deleted
    func deleteAll<T:Object>(object: T.Type) {
        do {
            try database?.write {
                if let objects = database?.objects(T.self) {
                    database?.delete(objects)
                }
            }
        } catch {
            assertionFailure("An error occurred while cleaning database: \(error)")
        }
    }
}
