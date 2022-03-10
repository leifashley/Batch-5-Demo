//
//  DetailRouter.swift
//  Batch 5 Demo
//
//  Created by Eric Personal on 3/8/22.
//

import Foundation
import UIKit

class DetailRouter {
    weak var presenter: DetailPresenter?
    var navigationController = UINavigationController()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showArticleWith(articleID: Int) {
        self.presenter?.showArticleWith(articleID: articleID)
    }
}
