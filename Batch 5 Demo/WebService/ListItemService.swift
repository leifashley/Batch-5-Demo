//
//  ListItemService.swift
//  Batch 5 Demo
//
//  Created by Rockford Wei on 2022-03-08.
//

protocol ListItemService {
    func getItem<T>(id: Int, completion: @escaping (T?, Error?) -> ())
}
