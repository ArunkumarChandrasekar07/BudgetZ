//
//  ToastStyle.swift
//  BudgetZ
//
//  Created by Arunkumar Chandrasekar on 18/01/23.
//

import SwiftUI

enum ToastStyle {
    case error
    case warning
    case success
    case info
    case loader
}

extension ToastStyle {
    var themeColor: Color {
        switch self {
        case .error: return Color.red
        case .warning: return Color.orange
        case .info: return Color.blue
        case .success: return Color.green
        case .loader: return Color.black
        }
    }
    
    var iconFileName: String {
        switch self {
        case .info: return "info.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .success: return "checkmark.circle.fill"
        case .error: return "xmark.circle.fill"
        case .loader: return ""
        }
    }
}

struct FancyToast: Equatable {
    var type: ToastStyle
    var title: String
    var message: String?
    var duration: Double?
}
