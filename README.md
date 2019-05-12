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

This framework was heavily inspired by blog posts written by the brilliant [John Sundell](https://www.swiftbysundell.com) and [Ray Wenderlich](https://www.raywenderlich.com/). I highly recommend them if you need to learn & improve your programming skills!.

# Using Netswift

## Prerequisites
I'm assuming you have an available iOS project set up with this cocoapod, ready to go. If not, please follow the [installation steps](#installation).

## Writing our first request
As all reputable tutorials, the following steps will help you set up our first Hello World request. 

#### What we'll do
- [Step 1](#step-1): Define a container which will act as the base of implementation for our API.
- [Step 2](#step-2): Implement `NetswiftRoute`, which defines the different `URLComponents` of our endpoints.
- [Step 3](#step-3): Implement `NetswiftRequest`, which defines how your container can be turned into a `URLRequest`
- [Step 4](#step-4): Passing it all to the generic `Netswift` class and performing your first request 🙌
- Step 5: ????
- Step 6: Profit 👍

#### Endpoint
To facilitate this tutorial, I went ahead and set up a mock API for you to query. It only has one endpoint, which returns a single object that contains a title. [Give it a try](https://my-json-server.typicode.com/MrSkwiggs/Netswift-HelloWorld/Netswift)

### Step 1
In this particular case, and to keep things simple, we can go ahead and define a new `enum`. We'll use it to implement the minimum required protocol functions which will allow us to perform our request.

So go ahead; add a new file to your project and name it however you like. I chose `MyAPI`. Then, don't forget to `import Netswift`, and create your API Container like such:
```
import Netswift

enum MyAPI {
  case helloWorld
}
```

And that's pretty much it. Now, since our API only has one endpoint, there's really nothing more to this enum. 
The great thing about Swift's enum is that they can also have associated values. This comes in very handy when you need to pass any additional data to your endpoint, all while keeping it type safe & structured. Neat 👌

### Step 2
So we have our enum. Great. But it doesn't do much. Less great.

Go ahead and define an extension for it, which implements `NetswiftRoute`:
```
extension MyAPI: NetswiftRoute {
}
```

Immediately, the compiler will complain. Pressing 'Add protocol stubs' will make it happy again. This will add two variables:
- `host`: This defines the domain of our API, usually something like www.example.com.
- `path`: A specific resource on our API. Unless you're just GET-ing a website, you'll need to define a path.

So let's go ahead and implement those two.
```
var host: String {
  return "my-json-server.typicode.com"
}

var path: String {
  switch self {
    case .helloWorld: return "MrSkwiggs/Netswift-HelloWorld"
  }
}
```

What did we just do ?

Our container is an `enum`, which means we can very easily define different return values given each case. For the host, we always want to return the same value. 

For the path however, we are taking advantage of this. We set it up in a future-proof way so that we can always add paths later. When that time comes, the compiler will yell at us for not covering all cases of our `enum` 👍

And that's pretty much everything we need for now. A lot of work is done under the hood by default; it's accessible and we can it if we need it, but in the context of this tutorial we don't need to anything else!

### Step 3
Now that we have our route setup, all we need to do is implement the `NetswiftRequest` protocol. Let us do just that in another extension.
```
extension MyAPI: NetswiftRequest {
}
```

This time, we don't want to let the compiler add protocol stubs for us just yet. Before we do that, let me explain what other information we need to provide to `Netswift` for it to be able to perform our request;
- A `Response` type. Since Netswift is generic, it doesn't know what kind of data you want from your API's endpoint. If our request defines a type called `Response`, we're good to go. Best part is, you could also just use a typealias, and it would just work 👍


## Example Project

To run the example project, clone the repo, and run `pod install` from the Example directory first.

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
