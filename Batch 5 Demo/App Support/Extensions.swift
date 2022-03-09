//
//  Extensions.swift
//  Batch 5 Demo
//
//  Created by Leif Ashley on 3/4/22.
//

import Combine
import Foundation
import UIKit

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
}
