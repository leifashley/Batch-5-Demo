//
//  UISearchListViewInteractor.swift
//  Batch 5 Demo
//
//  Created by Rockford Wei on 2022-03-08.
//

import Combine
import UIKit

protocol UISearchListViewInteractor {
    func setup(repository: NewsItemsRespository)
    
    func getNewsItems(searchString: String?, completion: @escaping ([NewsItem]) -> ()) 
    
    func assign(router: UISearchListViewRouter)
    func makeRoute(model: Any) -> UIViewController?
}
