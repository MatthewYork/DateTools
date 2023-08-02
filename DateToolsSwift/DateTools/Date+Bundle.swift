//
//  Date+Bundle.swift
//  DateTools
//
//  Created by Matthew York on 8/26/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import Foundation

public extension Bundle {

    class func dateToolsBundle() -> Bundle? {
        let assetPath: String?
#if SPM
        assetPath = Bundle.module.resourcePath
#else
        assetPath = Bundle(for: Constants.self).resourcePath
#endif
        guard let assetPath = assetPath else { return nil }
        return Bundle(path: NSString(string: assetPath).appendingPathComponent("DateTools.bundle"))
    }

}
