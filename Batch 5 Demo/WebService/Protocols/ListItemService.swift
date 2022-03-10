//
//  ListItemService.swift
//  Batch 5 Demo
//
//  Created by Rockford Wei on 2022-03-08.
//

import Combine
protocol ListItemService {
    func getItem<T: Decodable>(id: Int, placeholder: T, completion: @escaping (T) -> ()) -> AnyCancellable?
}
