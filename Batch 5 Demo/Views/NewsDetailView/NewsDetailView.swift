//
//  NewsDetailView.swift
//  Batch 5 Demo
//
//  Created by Rockford Wei on 2022-03-09.
//


import UIKit
import WebKit

class NewsDetailView: UIViewController {
    var newsItem = NewsItem()
    private let browser = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(browser)
        browser.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            browser.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            browser.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            browser.widthAnchor.constraint(equalTo: view.widthAnchor),
            browser.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        navigationItem.title = newsItem.title
        if let request = newsItem.url.asURLRequest() {
            browser.load(request)
        }
    }
}
