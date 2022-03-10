//
//  DetailView.swift
//  Batch 5 Demo
//
//  Created by Eric on 3/8/22.
//

import Foundation
import UIKit
import WebKit

class DetailView: UIViewController {
    var newArticle: Article?
    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = webView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let url = URL(string: newArticle?.url ?? "") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
