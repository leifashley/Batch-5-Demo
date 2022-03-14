//
//  ViewController.swift
//  Batch 5 Demo
//
//  Created by Leif Ashley on 3/7/22.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var NewsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Application-Title".localized()
    }


    @IBAction func onClick(_ sender: UIButton) {
        let interactor = NewsListViewInteractor()
        interactor.setup(repository: NewsItemsRespository())
        let router = NewsListViewRouter()
        let viewController = router.makeListViewController(interactor: interactor)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

