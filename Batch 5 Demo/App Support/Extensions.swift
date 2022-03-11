//
//  Extensions.swift
//  Batch 5 Demo
//
//  Created by Leif Ashley on 3/4/22.
//

import Combine
import Foundation
import UIKit

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "localized")
    }
}

extension UIColor {
    convenience init(webColorCode code: UInt) {
        let red   = CGFloat((code & 0xFF0000) >> 16)
        let green = CGFloat((code & 0xFF00) >> 8)
        let blue  = CGFloat(code & 0xFF)
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1.0)
    }
    convenience init(webColor: String) {
        var code = webColor
        if code.hasPrefix("#") {
            code = String(code.dropFirst())
        }
        let color = UInt(code, radix: 16) ?? 0
        self.init(webColorCode: color)
    }
    
//    //universal
//    static let primaryColor = UIColor(red: 232/255, green: 70/255, blue: 48/255, alpha: 1.0)
    
    //splines
    static let splinesColor = UIColor(named: "SplinesColor")
    
    //text
    static let textPrimaryColor = UIColor(named: "TextPrimaryColor")
    static let textSecondaryColor = UIColor(named: "TextSecondaryColor")
    
    //App background Color
    static let appBackgroundColor = UIColor(named: "AppBackgroundColor")
}
    

extension Date {
    static func iso8601Adaptive(_ decoder: Decoder) throws -> Date {
            let formats = [
                "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZZZZZ",
                "yyyy-MM-dd'T'HH:mm:ssZZZZZ",
                "yyyy-MM-dd'T'HH:mm:ss",
                "yyyy-MM-dd HH:mm:ss",
                "yyyy-M-d H:m:s"
            ]
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)
            let fmt = DateFormatter()
            for format in formats {
                fmt.dateFormat = format
                if let dt = fmt.date(from: dateStr) {
                    return dt
                }
            }
            throw Exception.invalidDateFormat
        }
    
    func getFormattedDate(format: String) -> String {
            let dateformat = DateFormatter()
            dateformat.dateFormat = format
            return dateformat.string(from: self)
        }
}

extension String {
    func assignWebImage<Root>(session: URLSession = .shared, to keypath: ReferenceWritableKeyPath<Root, UIImage>, on object: Root) -> AnyCancellable? {
        guard let url = URL(string: self) else {
            NSLog("rare exception: \(Exception.invalidURL)")
            return nil
        }
        return session.dataTaskPublisher(for: url)
            .tryMap { $0.data }
            .replaceError(with: Data())
            .compactMap { UIImage(data: $0) }
            .receive(on: DispatchQueue.main)
            .assign(to: keypath, on: object)
    }
    func asURLRequest() -> URLRequest? {
        if let url = URL(string: self) {
            return URLRequest(url: url)
        } else {
            return nil
        }
    }
}


extension UIFont {
    
    class func notoSansRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "NotoSans-Regular", size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    class func notoSansMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "NotoSans-Medium", size: size) ?? UIFont.systemFont(ofSize: size, weight: .medium)
    }
    
    class func notoSansSemibold(size: CGFloat) -> UIFont {
        return UIFont(name: "NotoSans-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .semibold)
    }
}


extension UIView {
    
    func addShadow(width: CGFloat = 0, height: CGFloat = 2, opacity: Float = 1, color: UIColor = UIColor.black.withAlphaComponent(0.1)) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: width, height: height)
    }
    
}


extension UIViewController{
    func setupNavBar() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.textPrimaryColor!, .font: UIFont.notoSansSemibold(size: 16)]
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.layoutIfNeeded()
        
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "Back_Icon"), landscapeImagePhone: .remove, style: .plain, target: self, action: #selector(backButtonTapped))
        leftBarButton.tintColor = .textPrimaryColor

        navigationItem.leftItemsSupplementBackButton = false
        navigationItem.leftBarButtonItem = leftBarButton

        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = .zero
        self.navigationController?.navigationBar.layer.shadowRadius = 4
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.2
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
