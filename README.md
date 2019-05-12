# Netswift

[![CI Status](https://img.shields.io/travis/MrSkwiggs/Netswift.svg?style=flat)](https://travis-ci.org/MrSkwiggs/Netswift)
[![Version](https://img.shields.io/cocoapods/v/Netswift.svg?style=flat)](https://cocoapods.org/pods/Netswift)
[![License](https://img.shields.io/cocoapods/l/Netswift.svg?style=flat)](https://cocoapods.org/pods/Netswift)
[![Platform](https://img.shields.io/cocoapods/p/Netswift.svg?style=flat)](https://cocoapods.org/pods/Netswift)

## What
This library takes care of the heavy lifting required to have a reusable & maintainable networking layer in your Swift apps.
It currently allows you to (somewhat) easily write simple network calls in a very structured way. It does so by using protocols with associated types & generic classes & structs very extensively.

## Why
Networking in Swift can be tedious from the get go if you're not too experienced. This is where Netswift aims to shine!

Over the past years, my team & I struggled with spaghetti code & an unmaintainable codebase when it came to performing network requests. Due to the nature of api calls, it is quite tough to find a single solution that accommodates most of your needs, all the while remaining flexible & future-proof.

So as a move to improve my Swift skills and get us out of messy situation, I took it upon myself to research & implement a solution that would alleviate those pain-points.

This framework was heavily inspired by blog posts written by the brilliant John Sundell (https://www.swiftbysundell.com) and Ray Wenderlich (https://www.raywenderlich.com/). I highly recommend them if you need to learn & improve your programming skills!.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

Netswift is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Netswift'
```

## Author

MrSkwiggs, 6209874+MrSkwiggs@users.noreply.github.com

## License

Netswift is available under the MIT license. See the LICENSE file for more info.

# Writing your first request with Netswift
As all reputable tutorials, the following steps will help you set up your first Hello World request.
