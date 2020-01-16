# Netswift

[![Build Status](https://travis-ci.org/MrSkwiggs/Netswift.svg?branch=master)](https://travis-ci.org/MrSkwiggs/Netswift)
[![Version](https://img.shields.io/cocoapods/v/Netswift.svg?style=flat)](https://cocoapods.org/pods/Netswift)
[![License](https://img.shields.io/cocoapods/l/Netswift.svg?style=flat)](https://cocoapods.org/pods/Netswift)
[![Platform](https://img.shields.io/cocoapods/p/Netswift.svg?style=flat)](https://cocoapods.org/pods/Netswift)

## What
This library takes care of the heavy lifting required to have a reusable & maintainable networking layer in your Swift apps.
It currently allows you to easily write network calls in a very structured and type-safe way. It does so by using protocols with associated types & generic classes & structs very extensively.

## Why
Networking in Swift can be tedious from the get go. Type safety & reusability are often overlooked for the sake of getting up to speed. This is where Netswift aims to shine!

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

And that's pretty much it. Now, since our API only has one endpoint, there's really nothing more to this. 
The great thing about Swift's `enum` is that they can also have associated values. This comes in very handy when you need to pass additional data to your endpoint, all while keeping it type-safe & structured. Neat 👌

### Step 2
So we have our enum. Great. But it doesn't do much. Let's fix that.

Go ahead and define an extension for it which implements the `NetswiftRoute` protocol:
```
extension MyAPI: NetswiftRoute {
}
```

Immediately, the compiler starts complaining. Pressing 'Add protocol stubs' will make it happy again. This will add two variables:
- `host`: This defines the domain of our API, usually something like www.example.com.
- `path`: A specific resource on our API. Unless you're just GET-ing a website, you'll need to define a path.

So let's go ahead and implement those two.
```
var host: String {
  return "my-json-server.typicode.com"
}

var path: String {
  switch self {
    case .helloWorld: return "MrSkwiggs/Netswift-HelloWorld/Netswift"
  }
}
```

What did we just do ?

Our container is an `enum`, which means we can very easily define different return values given each case. For the `host`, we always want to return the same value. 

For the `path` however, we are taking advantage of this feature. We set it up in a future-proof way so that we can always add paths later (as new enum cases). When that time comes, the compiler will yell at us for not covering all cases of our `enum` 👍

And that's pretty much everything we need for now. A lot of work is done under the hood by default; we can always define more information such as scheme (http or https) and query it if we need it, but in the context of this tutorial we can just skip ahead!

### Step 3
Now that we have our route setup, all we need to do is implement the `NetswiftRequest` protocol. Let us do just that in another extension:
```
extension MyAPI: NetswiftRequest {
}
```

This time, we don't want to let the compiler add protocol stubs for us just yet. Before we do that, let me explain what other information we need to provide to `Netswift`;
- A `Response` type. Since Netswift is generic, it doesn't know what kind of data we want from our API's endpoint. If our request defines a type called `Response`, we're good to go. And the best part is, we could also use a `typealias`, and it would just work 👍

So for now, let's just add an internal type named `Response` in our extension:
```
struct Response: JSONDecodable {
  let title: String
}
```

Again, what did we just write? 

Well, first of all, we define a type that mimics our endpoint's response structure. That is, an object that contains a member named `title`, which is of type `String`.

Then, we told the compiler that our `Response` type implements the JSONDecodable protocol. This is important for `Netswift`, as it tells it that we expect a JSON object back, for which we can use Swift's generic `JSONDecoder`. This is all done behind the scenes by default implementations. 

Yet, the compiler is still unhappy. Now's however a good time to let it 'Add protocol stubs'. We're now given a new function called `serialise`. This is the last part we need to define before we are good to go.

So let us implement our `URLRequest` serialisation then, shall we ?
```
func serialise(_ handler: @escaping NetswiftHandler<URLRequest>) {
  handler(.success(URLRequest(url: self.url)))
}
```

Alright what's all that, now ? Well, the `serialise` function lets `Netswift` get a useable `URLRequest` that it can send out. Since our implementation is so basic, though, all we need to do is instantiate a `URLRequest` with a given `URL`. But wait. Where's `self.url` coming from ?

This convenience computed variable comes from the `NetswiftRoute` protocol. All it does is to simply format all the URLComponents you've defined into a `String`, which it then uses to instantiate & return a `URL` object. 

Again, a lot of default implementation there, but all you need to know is that, for our current `.helloWorld` case, `self.url` will be using `<scheme><host>/<path><query>`.

Great, that's us pretty much done now!

### Step 4
Now's the moment we've been waiting for: sending out our request!

All we need to do is to actually perform our request. To do so, we can use an instance of the default `Netswift` class. All we need to do is call this:
```
Netswift().perform(MyAPI.helloWorld) { result in 
  guard let response = result.value else {
    if let error = result.error {
      print(error)
    }
    return
  }
  
  // Our request succeeded: we now have an object of type MyAPI.Response available to use
  print(response.title)
}
```

And that's our first request done with `Netswift`! From here, you can take it further and start defining more complex requests. I'd also suggest reading up the documentation and overriding default implementations to see what this library can really achieve 👌

## Example Project

To run the example project, clone the repo, and run `pod install` from the Example directory first. It contains the full implementation of the tutorial above, along a few other examples.

## Installation

Netswift is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Netswift'
```

## Author

[mailto:dorian@skwiggs.dev](Dorian Grolaux), https://skwiggs.dev

## License

Netswift is available under the MIT license. See the LICENSE file for more info.
