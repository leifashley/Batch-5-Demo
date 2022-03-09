//
//  NewsListViewInteractor.swift
//  Batch 5 Demo
//
//  Created by Rockford Wei on 2022-03-09.
//

import Combine
import UIKit

struct NewsListViewInteractor: UISearchListViewInteractor {
    
    private let presenter: UISearchListViewPresenter
    private var handlers: Set<AnyCancellable> = []
    
    init(presenter: UISearchListViewPresenter) {
        self.presenter = presenter
    }
    
    func subscribeListCount(serivce: ListCountService) {
    }
    
    func subscribeListing(service: ListingService) {
    }
    
    func subscribeListItem(service: ListItemService) {
    }
    
    
}
