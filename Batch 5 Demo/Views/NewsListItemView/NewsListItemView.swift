//
//  NewsListItemView.swift
//  Batch 5 Demo
//
//  Created by Rockford Wei on 2022-03-09.
//

import Combine
import UIKit

class NewsListItemView: UITableViewCell {
    
    @IBInspectable public var imageIcon: UIImage {
        get { iconView.image ?? UIImage() }
        set { iconView.image = newValue }
    }
    
    @IBInspectable public var textBanner: String? {
        get { bannerView.text }
        set { bannerView.text = newValue }
    }
    
    private var imageLoadingHandler: AnyCancellable? = nil
    static let cellHeight: CGFloat = 64
    public var model: NewsItemModel = NewsItemModel() {
        didSet {
            if model.id > 0 {
                imageLoadingHandler = model.imageUrl.assignWebImage(to: \.imageIcon, on: self)
                textBanner = model.title
            } else {
                imageLoadingHandler = nil
                imageIcon = UIImage()
                textBanner = nil
            }
        }
    }
    private let iconView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    private let bannerView: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        return view
    }()
    private func setupLayout() {
        contentView.addSubview(iconView)
        contentView.addSubview(bannerView)
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -16),
            iconView.widthAnchor.constraint(equalTo: iconView.heightAnchor),
            bannerView.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16),
            bannerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            bannerView.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            bannerView.heightAnchor.constraint(equalTo: iconView.heightAnchor)
        ])
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
}
