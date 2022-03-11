//
//  Repository.swift
//  Batch 5 Demo
//
//  Created by Leif Ashley on 3/11/22.
//

import Foundation

protocol Repository {
    associatedtype T: Codable
    associatedtype K
    
    func readAll() -> [T]
    func readById(id: K) -> T
    func create(_ entity: T)
    func update(_ id: K)
    func delete(_ id: K)
}

//class RepositoryTodo: Repository {
//    typealias T = Todo
//    typealias K = Int
//
//    func readAll() -> [T] {
//
//    }
//
//    func readById(id: K) -> T {
//
//    }
//
//    func create(_ entity: T) {
//
//    }
//
//    func update(_ id: K) {
//
//    }
//
//    func delete(_ id: K) {
//
//    }
//}
