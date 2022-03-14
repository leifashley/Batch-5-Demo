//
//  NewsListItemView.swift
//  Batch 5 Demo
//
//  Created by Rockford Wei on 2022-03-09.
//

import Combine
import UIKit

class NewsListItemView: UITableViewCell {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var splineView: UIView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var newsSiteLbl: UILabel!
    
    private var imageLoadingHandler: AnyCancellable? = nil
    
    public let defaultImage = UIImage(systemName: "photo") ?? UIImage()
    public var imageIcon: UIImage? {
        didSet {
            setImage()
        }
    }
    
    var presenter : NewsListItemViewPresenter?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLbl.font = .notoSansSemibold(size: 18)
        titleLbl.textColor = .textPrimaryColor
        
        timeLbl.font = .notoSansRegular(size: 10)
        timeLbl.textColor = .textPrimaryColor
        
        newsSiteLbl.font = .notoSansRegular(size: 10)
        newsSiteLbl.textColor = .textPrimaryColor
        
        splineView.backgroundColor = .splinesColor
        
        iconView.image = defaultImage
    }
    
    func showNewsItem() {
        presenter?.loadNewsItem()
    }
    
    func configure(model: NewsItem?) {
        if imageIcon == nil {
            if let imageUrl = model?.imageUrl, let url = URL(string: imageUrl) {
                print("ImageURL Loading: \(imageUrl)")
                imageLoadingHandler = url.assignWebImage(to: \.imageIcon, on: self)
            }
        } else {
            setImage()
        }
        
        titleLbl.text = model?.title
        timeLbl.text = model?.publishedAt.ago()
        newsSiteLbl.text = model?.newsSite
    }
    
    func setImage() {
        if imageIcon == nil {
            iconView.image = defaultImage
        } else {
            iconView.image = imageIcon
        }
    }
    

////
////     public var textBanner: String? {
////        get { bannerView.text }
////        set { bannerView.text = newValue }
////    }
//    
////
////
////    public var model: NewsItem = NewsItem() {
////        didSet {
////            if model.id > 0 {
//////
////                titleLbl.text = model.title
////        }
////    }
////
////    private let iconView: UIImageView = {
////        let img = UIImageView()
////        img.translatesAutoresizingMaskIntoConstraints = false
////        return img
////    }()
////
////    private let bannerView: UILabel = {
////        let view = UILabel()
////        view.translatesAutoresizingMaskIntoConstraints = false
////        view.numberOfLines = 0
////        return view
////    }()
//    
//    private func setupLayout() {
////        contentView.addSubview(iconView)
////        contentView.addSubview(bannerView)
////        NSLayoutConstraint.activate([
////            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
////            iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
////            iconView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -16),
////            iconView.widthAnchor.constraint(equalTo: iconView.heightAnchor),
////            bannerView.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16),
////            bannerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
////            bannerView.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
////            bannerView.heightAnchor.constraint(equalTo: iconView.heightAnchor)
////        ])
//    }
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: .default, reuseIdentifier: reuseIdentifier)
////        setupLayout()
//        self.cardView.addShadow()
//        self.titleLbl.font = .notoSansSemibold(size: 14)
//        self.titleLbl.textColor = .textPrimaryColor
//    }
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
////        setupLayout()
//    }
}
