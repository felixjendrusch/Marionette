//
//  MediaTiming.swift
//  Marionette
//
//  Created by Felix Jendrusch on 1/29/15.
//  Copyright (c) 2015 Felix Jendrusch. All rights reserved.
//

import UIKit

public enum FillMode {
    case Removed
    case Forwards
    case Backwards
    case Both

    public var name: String! {
        switch self {
        case .Removed:
            return kCAFillModeRemoved
        case .Forwards:
            return kCAFillModeForwards
        case .Backwards:
            return kCAFillModeBackwards
        case .Both:
            return kCAFillModeBoth
        }
    }
}

public protocol MediaTiming {
    var beginTime: CFTimeInterval { get set }
    var duration: CFTimeInterval { get set }
    var speed: Float { get set }
    var timeOffset: CFTimeInterval { get set }
    var repeatCount: Float { get set }
    var repeatDuration: CFTimeInterval { get set }
    var autoreverses: Bool { get set }
    var fillMode: FillMode! { get set }
}
