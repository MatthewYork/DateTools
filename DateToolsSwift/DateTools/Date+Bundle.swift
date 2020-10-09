//
//  Date+Bundle.swift
//  DateTools
//
//  Created by Matthew York on 8/26/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import Foundation

public extension Bundle {
    
    class func dateToolsBundle() -> Bundle {
        let containerBundle: Bundle
        
        #if SWIFT_PACKAGE
        containerBundle = Bundle.module
        #else
        containerBundle = Bundle(for: Constants.self)
        #endif
        
        guard
            let dateToolsBundleURL = containerBundle.url(forResource: "DateTools", withExtension: "bundle"),
            let dateToolsBundle = Bundle(url: dateToolsBundleURL)
        else {
            assertionFailure("Make sure you have included DateTools.bundle in your app.")
            return containerBundle
        }
        
        return dateToolsBundle
    }
}

