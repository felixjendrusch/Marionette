# Marionette

Concise and type safe `CALayer` animations! *Experimental*

## Example

Let's start with an example demonstrating how to move a layer from `(50, 50)` to `(150, 150)` while also changing its background color from red to blue:

```swift
animateLayer(layer, withDuration: 5, timingFunction: .EaseInEaseOut) { layer in
  layer.position ~= CGPointMake(50, 50) ... CGPointMake(150, 150)
  layer.backgroundColor ~= UIColor.redColor().CGColor ... UIColor.blueColor().CGColor
}
```

which is equivalent to:

```swift
let positionAnimation = CABasicAnimation(keyPath: "position")
positionAnimation.fromValue = NSValue(CGPoint: CGPointMake(50, 50))
positionAnimation.toValue = NSValue(CGPoint: CGPointMake(150, 150))

let backgroundColorAnimation = CABasicAnimation(keyPath: "backgroundColor")
backgroundColorAnimation.fromValue = UIColor.redColor().CGColor
backgroundColorAnimation.toValue = UIColor.blueColor().CGColor

let animationGroup = CAAnimationGroup()
animationGroup.animations = [positionAnimation, backgroundColorAnimation]
animationGroup.duration = 5
animationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

layer.addAnimation(animationGroup, forKey: nil)
```

## Usage

The `animateLayer` function takes your `CALayer` as well as a closure in which you create the animations for your layer:

```swift
animateLayer(layer) { layer in
  layer.cornerRadius ~= 0 ... 10
  return
}
```

If you create more than one animation inside the closure, they are grouped together using `CAAnimationGroup`. Optionally, `animateLayer` takes a duration and timing function to configure this group:

```swift
animateLayer(layer, withDuration: 5, timingFunction: .EaseInEaseOut) { layer in
  layer.shadowOpacity ~= 0 ... 0.5
  layer.shadowOffset ~= CGSizeMake(0, 0) ... CGSizeMake(0, -3)
}
```

Animations are automatically added to your layer. `animateLayer` also takes an optional key to be used when adding your animations:

```swift
animateLayer(layer, forKey: "boundsChange", block: { layer in
  layer.bounds ~= CGRectMake(0, 0, 100, 100) ... CGRectMake(0, 0, 50, 50)
})
```

Setting a timing function per animation is also very easy:

```swift
layer.opacity ~= (1 ... 0) ~ .EaseOut
```

It's recommended to always specify `from` and `to` values using the standard range syntax `from ... to`, but you can also specify just one using `from...` and `...to`. `by` values are supported as well:

```swift
layer.borderWidth ~= BasicAnimation(fromValue: 0, byValue: 2)
```

Besides being very concise, type safety is also ensured. Several enums are provided to work with fill modes, media timing functions and value functions:

```swift
let animation = BasicAnimation(toValue: 1, byValue 0.5)
animation.fillMode = .Both

layer.position ~= animation // won't compile
```

The `transaction` and `transactionWithDuration` functions can be used to ease working with `CATransaction`:

```swift
transactionWithDuration(5, timingFunction: .EaseIn) {
  animateLayer(...) { ... }
}
```

## Supported properties

The following animatable properties are supported on `CALayer`:

`bounds`, `position`, `zPosition`, `anchorPoint`, `anchorPointZ`, `transform`, `hidden`, `doubleSided`, `sublayerTransform`, `masksToBounds`, `contents`, `contentsRect`, `contentsScale`, `contentsCenter`, `minificationFilterBias`, `backgroundColor`, `cornerRadius`, `borderWidth`, `borderColor`, `opacity`, `composingFilter`, `filters`, `backgroundFilters`, `shouldRasterize`, `rasterizationScale`, `shadowColor`, `shadowOpacity`, `shadowOffset`, `shadowRadius`, `shadowPath`

Properties specific to `CALayer` subclasses are not yet supported.

## Behind the proxy

Marionette uses a proxy object and custom operator functions similar to [Cartography](https://github.com/robb/Cartography).

## Contact

I'm [Felix](http://felixjendrusch.is), you can follow me on [Twitter](https://twitter.com/felixjendrusch) :wave:
