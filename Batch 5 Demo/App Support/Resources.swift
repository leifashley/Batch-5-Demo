//
//  Skin.swift
//  Batch 5 Demo
//
//  Created by Rockford Wei on 2022-03-07.
//

import Foundation
import UIKit


class Resources {
    private static let resourcesKey = "Resources"
    private static let stringsKey = "Strings"
    private static let colorsKey = "Colors"
    
    private static var this: [String: [String: String]] {
        return Bundle.main.infoDictionary?[resourcesKey] as? [String: [String: String]] ?? [:]
    }
    
    private static var strings: [String: String] {
        return this[stringsKey] ?? [:]
    }
    
    static func `string`(_ key: String) -> String {
        return strings[key] ?? ""
    }
}

typealias R = Resources
