//
//  NewsListViewRouter.swift
//  Batch 5 Demo
//
//  Created by Rockford Wei on 2022-03-09.
//
import UIKit

class NewsListViewRouter: UISearchListViewRouter {
    func makeListViewController(interactor: UISearchListViewInteractor) -> UIViewController {
        guard let viewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: UISearchListViewController.storyboardId) as? UISearchListViewController else {
            // Thowing high level fatalErrors here is likely to crash the app, usuually better to log the error, and send back a default
            //fatalError("unexpected view controller type")
            log.error(title: "NewsListViewRouter.makeListViewController", "Could not instantiate viewController from storyboard", error: AppError.unknownError)
            return UIViewController()
        }
        
        let presenter = NewsListViewPresenter()
        presenter.assign(interactor: interactor)
        interactor.assign(router: self)
        viewController.presenter = presenter
        
        return viewController
    }
    
    func makeDetailViewController(model: Any) -> UIViewController? {
        guard let model = model as? NewsItem else {
            log.error(title: "NewsListViewRouter.makeDetailViewController", "Incorrect data model type", error: AppError.unknownError)
            return nil
        }
        
        let viewController = NewsDetailView()
        viewController.newsItem = model
        
        return viewController
    }
}
