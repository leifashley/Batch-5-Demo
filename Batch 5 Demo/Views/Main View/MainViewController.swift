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

    var tapGesture: UITapGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Application-Title".localized()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture = gesture
        mainView.addGestureRecognizer(gesture)
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

