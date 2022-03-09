//
//  ViewController.swift
//  Batch 5 Demo
//
//  Created by Leif Ashley on 3/7/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = R.string("ApplicationTitle")
        
        // Example of how to call the detail view
        let router = DetailRouter(navigationController: self.navigationController ?? UINavigationController())
        let presenter = DetailPresenter(router: router)
        router.presenter = presenter
        router.showArticleWith(articleID: 0)
    }


}

