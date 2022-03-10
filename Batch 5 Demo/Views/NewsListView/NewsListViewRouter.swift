//
//  NewsListViewRouter.swift
//  Batch 5 Demo
//
//  Created by Rockford Wei on 2022-03-09.
//
import UIKit

class NewsListViewRouter: UISearchListViewRouter {
    func makeListViewController(interactor: UISearchListViewInteractor) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: UISearchListViewController.storyboardId) as? UISearchListViewController else {
            fatalError("unexpected view controller type")
        }
        
        let presenter = NewsListViewPresenter()
        presenter.assign(interactor: interactor)
        interactor.assign(router: self)
        viewController.presenter = presenter
        
        return viewController
    }
    
    func makeDetailViewController(model: Any) -> UIViewController {
        guard let model = model as? NewsItem else {
            fatalError("unexpected data model type")
        }
        
        let viewController = NewsDetailView()
        viewController.newsItem = model
        
        return viewController
    }
}
