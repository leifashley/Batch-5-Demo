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
        
        navigationItem.title = "Application-Title".localized()
    }


    @IBAction func onClick(_ sender: UIButton) {
        let interactor = NewsListViewInteractor()
        interactor.setup(service: NewsListingService())
        let router = NewsListViewRouter()
        let viewController = router.makeListViewController(interactor: interactor)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

