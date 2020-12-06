//
//  List.swift
//  ToDo
//
//  Created by iGhibli on 2020/11/29.
//

import UIKit

struct ListsModel {
    var icon: String = ""
    var title: String = ""
    var count: Int = 0
    var color = ListColor.red    
}

enum ListIcon {
    case list
}

// 默认枚举不能直接用UIColor作为原始值
enum ListColor {
    case red
    case orange
    case yellow
    case green
    case teal
    case blue
    case purple
    case pink
    case indigo
    case gray
}

// 通过遵守协议RawRepresentable可以把UIColor作为原始值
extension ListColor: RawRepresentable {
    typealias RawValue = UIColor
    
    init?(rawValue: RawValue) {
        switch rawValue {
        case UIColor.red: self = .red
        case UIColor.orange: self = .orange
        case UIColor.yellow: self = .yellow
        case UIColor.green: self = .green
        case UIColor.systemTeal: self = .teal
        case UIColor.blue: self = .blue
        case UIColor.purple: self = .purple
        case UIColor.systemPink: self = .pink
        case UIColor.systemIndigo: self = .indigo
        case UIColor.systemGray: self = .gray
        default: return nil
        }
    }
    
    var rawValue: RawValue {
        switch self {
        case .red: return UIColor.red
        case .orange: return UIColor.orange
        case .yellow: return UIColor.yellow
        case .green: return UIColor.green
        case .teal: return UIColor.systemTeal
        case .blue: return UIColor.blue
        case .purple: return UIColor.purple
        case .pink: return UIColor.systemPink
        case .indigo: return UIColor.systemIndigo
        case .gray: return UIColor.systemGray
        }
    }
}
