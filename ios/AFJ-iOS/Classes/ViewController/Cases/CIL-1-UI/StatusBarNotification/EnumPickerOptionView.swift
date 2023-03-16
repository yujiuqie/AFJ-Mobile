//
//

import SwiftUI

protocol StringRepresentable {
    var stringValue: String { get }
}

extension IncludedStatusBarNotificationStyle: StringRepresentable {
    var stringValue: String {
        switch self {
        case .defaultStyle: return ".defaultStyle"
        case .light: return ".light"
        case .dark: return ".dark"
        case .success: return ".success"
        case .warning: return ".warning"
        case .error: return ".error"
        case .matrix: return ".matrix"
        default: return "?"
        }
    }
}

extension StatusBarNotificationAnimationType: StringRepresentable {
    var stringValue: String {
        switch self {
        case .move: return ".move"
        case .fade: return ".fade"
        case .bounce: return ".bounce"
        default: return "?"
        }
    }
}

extension StatusBarNotificationBackgroundType: StringRepresentable {
    var stringValue: String {
        switch self {
        case .fullWidth: return ".fullWidth"
        case .pill: return ".pill"
        default: return "?"
        }
    }
}

extension StatusBarNotificationSystemBarStyle: StringRepresentable {
    var stringValue: String {
        switch self {
        case .defaultStyle: return ".defaultStyle"
        case .lightContent: return ".lightContent"
        case .darkContent: return ".darkContent"
        default: return "?"
        }
    }
}

extension StatusBarNotificationLeftViewAlignment: StringRepresentable {
    var stringValue: String {
        switch self {
        case .left: return ".left"
        case .centerWithText: return ".centerWithText"
        default: return "?"
        }
    }
}

extension StatusBarNotificationProgressBarPosition: StringRepresentable {
    var stringValue: String {
        switch self {
        case .top: return ".top"
        case .center: return ".center"
        case .bottom: return ".bottom"
        default: return "?"
        }
    }
}

struct EnumPickerOptionView<T: StringRepresentable>: View where T: Hashable {
    var representable: T

    init(_ representable: T) {
        self.representable = representable
    }

    var body: some View {
        Text(representable.stringValue).tag(representable)
    }
}

@available(iOS 15.0, *)
struct EnumPickerOptionView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            SegmentedPicker(title: "Test", value: .constant(IncludedStatusBarNotificationStyle.dark)) {
                EnumPickerOptionView(IncludedStatusBarNotificationStyle.light)
                EnumPickerOptionView(IncludedStatusBarNotificationStyle.dark)
            }
        }
    }
}
