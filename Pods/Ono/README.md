# Ono (斧)
**A sensible way to deal with XML & HTML for iOS & Mac OS X**

XML support in Cocoa isn't great (unless, of course, the XML in question is a `.plist`). `NSXMLParser` forces a cumbersome delegate model, which is extremely inconvenient to implement. `NSXMLDocument` is a bit nicer to use, but only works on Mac OS X, and has a large memory footprint.

**Ono makes working with XML & HTML as nice as JSON.**

Whether your app needs to interface with a XML-RPC webservice, scrape a website, or parse an RSS feed, Ono will make your day a whole lot less terrible.

> Ono (斧) means "axe", in homage to [Nokogiri](http://nokogiri.org) (鋸), which means "saw".

> Using [AFNetworking](https://github.com/AFNetworking/AFNetworking)? Easily integrate Ono into your networking stack with [AFOnoResponseSerializer](https://github.com/AFNetworking/AFOnoResponseSerializer).

## Features

- Simple, modern API following standard Objective-C conventions, including extensive use of blocks and `NSFastEnumeration`
- Extremely performant document parsing and traversal, powered by `libxml2`
- Support for both [XPath](http://en.wikipedia.org/wiki/XPath) and [CSS](http://en.wikipedia.org/wiki/Cascading_Style_Sheets) queries
- Automatic conversion of date and number values
- Correct, common-sense handling of XML namespaces for elements and attributes
- Ability to load HTML and XML documents from either `NSString` or `NSData`
- Full documentation
- Comprehensive test suite

## Installation

[CocoaPods](http://cocoapods.org) is the recommended method of installing Ono. Simply add the following line to your `Podfile`:

#### Podfile

```ruby
pod 'Ono'
```

## Usage

```objective-c
#import "Ono.h"

NSData *data = ...;
NSError *error;

ONOXMLDocument *document = [ONOXMLDocument XMLDocumentWithData:data error:&error];
for (ONOXMLElement *element in document.rootElement.children) {
    NSLog(@"%@: %@", element.tag, element.attributes);
}

// Support for Namespaces
NSString *author = [[document.rootElement firstChildWithTag:@"creator" inNamespace:@"dc"] stringValue];

// Automatic Conversion for Number & Date Values
NSDate *date = [[document.rootElement firstChildWithTag:@"created_at"] dateValue]; // ISO 8601 Timestamp
NSInteger numberOfWords = [[[document.rootElement firstChildWithTag:@"word_count"] numberValue] integerValue];
BOOL isPublished = [[[document.rootElement firstChildWithTag:@"is_published"] numberValue] boolValue];

// Convenient Accessors for Attributes
NSString *unit = [document.rootElement firstChildWithTag:@"Length"][@"unit"];
NSDictionary *authorAttributes = [[document.rootElement firstChildWithTag:@"author"] attributes];

// Support for XPath & CSS Queries
[document enumerateElementsWithXPath:@"//Content" usingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *stop) {
    NSLog(@"%@", element);
}];
```

## Demo

Build and run the example project in Xcode to see `Ono` in action.

## Requirements

Ono is compatible with iOS 5 and higher, as well as Mac OS X 10.7 and higher. It requires the `libxml2` library, which is included automatically when installed with CocoaPods, or can be added manually by adding "libxml2.dylib" to the target's "Link Binary With Libraries" build phase.

### Contact

[Mattt Thompson](http://github.com/mattt)
[@mattt](https://twitter.com/mattt)

## License

Ono is available under the MIT license. See the LICENSE file for more info.
