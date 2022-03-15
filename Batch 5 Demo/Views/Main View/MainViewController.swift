//
//  ViewController.swift
//  Batch 5 Demo
//
//  Created by Leif Ashley on 3/7/22.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var NewsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Application-Title".localized()
        
        mainView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }

    @IBAction func onClick(_ sender: UIButton) {
        pushViewController()
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            pushViewController()
        }
    }
    
    func pushViewController() {
        let interactor = NewsListViewInteractor()
        interactor.setup(repository: NewsItemsRespository())
        let router = NewsListViewRouter()
        let viewController = router.makeListViewController(interactor: interactor)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

