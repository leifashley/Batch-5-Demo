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
    
    func asURLRequest() -> URLRequest? {
        if let url = URL(string: self) {
            return URLRequest(url: url)
        } else {
            return nil
        }
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
    
    static func | (lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else { return lightMode }
        
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .dark ? darkMode : lightMode
        }
    }
    
//    //universal
//    static let primaryColor = UIColor(red: 232/255, green: 70/255, blue: 48/255, alpha: 1.0)
    
    //splines
    static let splinesColor = UIColor(named: "SplinesColor")

    //text
    static let textPrimaryColor = UIColor(named: "TextPrimaryColor") ?? (UIColor.white | UIColor.black)
    static let textSecondaryColor = UIColor(named: "TextSecondaryColor")
    
    //App background Color
    static let appBackgroundColor = UIColor(named: "AppBackgroundColor")
}
    

extension Date {
    static func iso8601Adaptive(_ decoder: Decoder) -> Date {
        let formats = [
            "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZZZZZ",
            "yyyy-MM-dd'T'HH:mm:ssZZZZZ",
            "yyyy-MM-dd'T'HH:mm:ss",
            "yyyy-MM-dd HH:mm:ss",
            "yyyy-M-d H:m:s"
        ]
        
        do {
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)
            let fmt = DateFormatter()
            
            for format in formats {
                fmt.dateFormat = format
                if let dt = fmt.date(from: dateStr) {
                    return dt
                }
            }
            
            log.error(title: "iso8601Adaptive", "could not formate date", error: AppError.unknownError)
        } catch {
            log.error(title: "iso8601Adaptive", "could not decode date", error: error)
        }
        
        return Date()
    }
    
    func getFormattedDate(format: String) -> String {
            let dateformat = DateFormatter()
            dateformat.dateFormat = format
            return dateformat.string(from: self)
        }
    func ago() -> String {
        let interval = Date().timeIntervalSince(self)

        switch interval {
        case 0..<60:
            return "Just now"
        case 60..<120:
            return "A minute ago"
        case 120..<3600:
            return "\(String(format: "%.0f", interval / 60)) minutes ago"
        case 3600..<7200:
            return "An hour ago"
        case 7200..<86400:
            return "\(String(format: "%.0f", interval / 60 / 60)) hours ago"
        default:
            let days = Int(interval / 86400)
            let weeks = days / 7
            
            if weeks > 1 {
                return getFormattedDate(format: "dd/MM/yy HH:mm")
            } else if days > 1 {
                return "\(days) days ago"
            } else {
                return "Yesterday"
            }
        }
    }
}

extension URL {
    func assignWebImage<Root>(session: URLSession = .shared, to keypath: ReferenceWritableKeyPath<Root, UIImage?>, on object: Root) -> AnyCancellable {
        return session.dataTaskPublisher(for: self)
            .tryMap { $0.data }
            .replaceError(with: Data())
            .compactMap { UIImage(data: $0) }
            .receive(on: DispatchQueue.main)
            .assign(to: keypath, on: object)
    }
}

extension URLComponents {
    
    /// Assists in adding name/value pairs to a URLComponent, for cleaner code
    mutating func addQueryString(name: String, value: String) {
        if queryItems == nil {
            queryItems = [URLQueryItem]()
        }
        
        queryItems?.append(URLQueryItem(name: name, value: value))
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
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.textPrimaryColor, .font: UIFont.notoSansSemibold(size: 16)]
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


extension Bundle {
    
    /// Loads a static resource from the main bundle and inflates the JSON to the given type
    /// - Returns: Type object or nil if no data was found
    func loadJson<T>(type: T.Type, resourceName: String) -> T? where T: Decodable {
        var result: T? = nil
        
        if let path = Bundle.main.path(forResource: resourceName, ofType: "json"), let data = FileManager.default.contents(atPath: path) {
            log.verbose("Path: \(path)")
            
            let decoder = JSONDecoder()
            
            do {
                result = try decoder.decode(T.self, from: data)
            } catch {
                log.error("Static JSON decode error for '\(resourceName)'", error: error)
            }
        } else {
            log.error("FATAL: cannot find json resource '\(resourceName)'", error: AppError.unknownError)
        }
        
        return result
    }
    
    
    /// Loads a static plist XML file and inflates the XML to the given type
    /// - Returns: Type object or nil if no data was found
    static func decodeFromPList<T>(_ type: T.Type, forResource: String) -> T? where T: Decodable {
        let logTitle = "Bundle.decodeFromPList"
        var t: T? = nil
        
        if let path = Bundle.main.path(forResource: forResource, ofType: "plist") {
            log.verbose("\(logTitle) Path: \(path)")
            
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    let decoded = try PropertyListDecoder().decode(type, from: data)
                    t = decoded
                } catch {
                    log.error("\(logTitle)", error: error)
                }
            }
            
        }
        
        return t
    }
}


extension UIImageView {
    
    func addSolidColor(color: UIColor){
        self.image = self.image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
    
}
