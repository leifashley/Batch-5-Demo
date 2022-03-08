//
//  ListingService.swift
//  Batch 5 Demo
//
//  Created by Rockford Wei on 2022-03-08.
//

protocol ListingService {
    func getList<T>(keywords: String?, start: Int, limit: Int, completion: @escaping ([T], Error?) -> ())
}
