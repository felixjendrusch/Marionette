//
//  Property.swift
//  Marionette
//
//  Created by Felix Jendrusch on 1/28/15.
//  Copyright (c) 2015 Felix Jendrusch. All rights reserved.
//

import UIKit

public class Property<T> {
    internal let context: Context

    internal let layer: CALayer
    internal let keyPath: String

    internal let pack: T -> AnyObject
    internal let unpack: AnyObject -> T

    public var value: T! {
        get {
            if let value: AnyObject = layer.valueForKeyPath(keyPath) {
                return unpack(value)
            } else {
                return nil
            }
        }
        set {
            let value: AnyObject = pack(newValue)
            layer.setValue(value, forKeyPath: keyPath)
        }
    }

    internal init(_ context: Context, _ layer: CALayer, _ keyPath: String, _ pack: T -> AnyObject, _ unpack: AnyObject -> T) {
        self.context = context

        self.layer = layer
        self.keyPath = keyPath

        self.pack = pack
        self.unpack = unpack
    }
}
