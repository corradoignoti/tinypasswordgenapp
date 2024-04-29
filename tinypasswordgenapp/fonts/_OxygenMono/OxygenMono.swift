//
//  OxygenMono.swift
//  tinypasswordgenapp
//
//  Created by corrado.ignoti on 29/04/24.
//
import SwiftUI

enum FontWeight {
    case regular
}

extension Font {
    static let oxygenMono: (FontWeight, CGFloat) -> Font = { fontType, size in
        switch fontType {
        case .regular:
            Font.custom("OxygenMono-Regular", size: size)
        }
    }
}

extension Text {
    func oxygenMono(_ fontWeight: FontWeight? = .regular, _ size: CGFloat? = nil) -> Text {
        return self.font(.oxygenMono(fontWeight ?? .regular, size ?? 16))
    }
}
