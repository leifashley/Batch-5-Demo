//
//  UISearchListViewInteractor.swift
//  Batch 5 Demo
//
//  Created by Rockford Wei on 2022-03-08.
//

protocol UISearchListViewInteractor {
    func assign(presenter: UISearchListViewPresenter)
    func subscribeListCount(serivce: ListCountService)
    func subscribeListing(service: ListingService)
    func subscribeListItem(service: ListItemService)
}
