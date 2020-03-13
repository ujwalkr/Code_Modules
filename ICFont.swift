//
//  ICFont.swift
//  MOH
//
//  Created by Ujwal K Raikar on 30/06/19.
//  Copyright © 2019 Incture. All rights reserved.
//

import Foundation
import UIKit

enum ICFont: String {
    case montserratRegular = "Montserrat-Regular"
    case montserratMedium = "Montserrat-Medium"
    case montserratBold = "Montserrat-Bold"
    case montserratLight = "Montserrat-Light"
    case montserratSemiBold = "Montserrat-SemiBold"
}

enum ICFontType {
    
    case headline1
    case headline2
    case headline3
    case subhead
    case paragraph
    case action
    case caption
    case overline
    
    
    /// As per Zeplin design font family guidlines
    var font: UIFont {
        switch self {
        case .headline1:
            return ICCustomFont.getFont(forFont: .montserratSemiBold,textStyle: .largeTitle)
        case .headline2:
            return ICCustomFont.getFont(forFont: .montserratSemiBold,textStyle: .title2)
        case .headline3:
            return ICCustomFont.getFont(forFont:.montserratSemiBold,textStyle: .title3)
        case .subhead:
            return ICCustomFont.getFont(forFont:.montserratSemiBold,textStyle: .callout)
        case .paragraph:
            return ICCustomFont.getFont(forFont: .montserratRegular, textStyle: .callout)
        case .action:
            return ICCustomFont.getFont(forFont: .montserratBold, textStyle: .callout)
        case .caption:
            return ICCustomFont.getFont(forFont: .montserratLight, textStyle: .caption1)
        case .overline:
            return ICCustomFont.getFont(forFont: .montserratLight, textStyle: .caption1)
        }
    }
}

struct ICCustomFont {
    
    var customFont: UIFont!
    
    var icLargeTitle: UIFont {
        let font = UIFontMetrics(forTextStyle: .largeTitle).scaledFont(for: customFont)
        
        return font
    }
    
    var icTitle1: UIFont {
        let font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: customFont)
        return font
    }
    
    var icTitle2: UIFont {
        let font = UIFontMetrics(forTextStyle: .title2).scaledFont(for: customFont)
        return font
    }
    
    var icTitle3: UIFont {
        let font = UIFontMetrics(forTextStyle: .title3).scaledFont(for: customFont)
        return font
    }
    
    var icBody: UIFont {
        let font = UIFontMetrics(forTextStyle: .body).scaledFont(for: customFont)
        return font
    }
    
    var icHeadline: UIFont {
        let font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: customFont)
        return font
    }
    
    var icSubheadline: UIFont {
        let font = UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: customFont)
        return font
    }
    
    var icCallout: UIFont {
        let font = UIFontMetrics(forTextStyle: .callout).scaledFont(for: customFont)
        return font
    }
    
    var icCaption1: UIFont {
        let font = UIFontMetrics(forTextStyle: .caption1).scaledFont(for: customFont)
        return font
    }
    
    var icCaption2: UIFont {
        let font = UIFontMetrics(forTextStyle: .caption2).scaledFont(for: customFont)
        return font
    }
    
    var icFootnote: UIFont {
        let font = UIFontMetrics(forTextStyle: .footnote).scaledFont(for: customFont)
        return font
    }
    
    init(fontName: ICFont = .montserratMedium ) {
        guard let customFont = UIFont(name: fontName.rawValue , size: UIFont.systemFontSize) else {
            fatalError("""
        Failed to load the "\(fontName.rawValue)" font.
        Make sure the font file is included in the project and the font name is spelled correctly.
        """
            )
        }
        
        self.customFont = customFont
    }
    
    init(){}
    
    static func getFont(forFont fontName: ICFont = .montserratMedium, textStyle: UIFont.TextStyle) -> UIFont {
        let userFont = UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle)
        let pointSize = userFont.pointSize
        
        

        guard let customFont = UIFont(name: fontName.rawValue , size: pointSize) else {
            fatalError("""
                Failed to load the "\(fontName.rawValue)" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
    
        return UIFontMetrics.default.scaledFont(for: customFont)
    }
    
}
