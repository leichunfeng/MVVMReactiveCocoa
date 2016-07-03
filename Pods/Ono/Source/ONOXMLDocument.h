// ONOXMLDocument.h
//
// Copyright (c) 2014 Mattt Thompson (http://mattt.me/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>

@class ONOXMLElement;

@class ONOXPathFunctionResult;

/**
 The `ONOSearching` protocol is adopted by `ONOXMLDocument` and `ONOXMLElement`, denoting that they can search for elements using XPath or CSS selectors.

 @see http://www.w3.org/TR/xpath/
 @see http://www.w3.org/TR/CSS21/selector.html
 */
@protocol ONOSearching

///---------------------------
/// @name Searching with XPath
///---------------------------

/**
 Returns the results for an XPath selector.
 
 @param XPath The XPath selector
 
 @return An enumerable collection of results.
 */
- (id <NSFastEnumeration>)XPath:(NSString *)XPath;

/**
 Returns the result for an XPath selector that contains XPath function.
 
 @param XPath The XPath selector
 
 @return The function result
 */
- (ONOXPathFunctionResult *)functionResultByEvaluatingXPath:(NSString *)XPath;

/**
 @deprecated Use `enumerateElementsWithXPath:usingBlock:` instead
 */
- (void)enumerateElementsWithXPath:(NSString *)XPath
                             block:(void (^)(ONOXMLElement *element))block DEPRECATED_ATTRIBUTE;

/**
 Enumerate elements matching an XPath selector.
 
 @param XPath The XPath selector
 @param block A block that is executed for each result. This block has no return value and takes three arguments:
    element: The enumerated element.
    idx: The index of the current item.
    stop: The block can set the value to `YES` to stop further processing of the elements. The stop argument is an out-only argument. You should only ever set this BOOL to `YES` within the block.
 */
- (void)enumerateElementsWithXPath:(NSString *)XPath
                        usingBlock:(void (^)(ONOXMLElement *element, NSUInteger idx, BOOL *stop))block;

/**
 Returns the first elements matching an XPath selector, or `nil` if there are no results.
 
 @param XPath The XPath selector
 
 @return The child element.
 */
- (ONOXMLElement *)firstChildWithXPath:(NSString *)XPath;

///---------------------------
/// @name Searching with CSS
///---------------------------

/**
 Returns the results for a CSS selector.

 @param CSS The CSS selector

 @return An enumerable collection of results.
 */
- (id <NSFastEnumeration>)CSS:(NSString *)CSS;

/**
 @deprecated Use `enumerateElementsWithCSS:usingBlock:` instead
 */
- (void)enumerateElementsWithCSS:(NSString *)CSS
                           block:(void (^)(ONOXMLElement *element))block DEPRECATED_ATTRIBUTE;

/**
 Enumerate elements matching a CSS selector.
 
 @param CSS The CSS selector
 @param block A block that is executed for each result. This block has no return value and takes three arguments:
    element: the enumerated element.
    idx: the index of the current item.
    stop: the block can set the value to `YES` to stop further processing of the elements. The stop argument is an out-only argument. You should only ever set this BOOL to `YES` within the block.
 */
- (void)enumerateElementsWithCSS:(NSString *)CSS
                      usingBlock:(void (^)(ONOXMLElement *element, NSUInteger idx, BOOL *stop))block;

/**
 Returns the first elements matching a CSS selector, or `nil` if there are no results.
 
 @param CSS The CSS selector
 
 @return The child element.
 */
- (ONOXMLElement *)firstChildWithCSS:(NSString *)CSS;

@end

#pragma mark -

/**
 `ONOXMLDocument` encapsulates an XML or HTML document, which can be searched and queried.
 */
@interface ONOXMLDocument : NSObject <ONOSearching, NSCopying, NSCoding>

///------------------------------------
/// @name Accessing Document Attributes
///------------------------------------

/**
 The XML version.
 */
@property (readonly, nonatomic, copy) NSString *version;

/**
 The string encoding for the document. This is 0 if no encoding is set, or it cannot be calculated.
 */
@property (readonly, nonatomic, assign) NSStringEncoding stringEncoding;


///---------------------------------
/// @name Accessing the Root Element
///---------------------------------

/**
 The root element of the document.
 */
@property (readonly, nonatomic, strong) ONOXMLElement *rootElement;

///------------------------------------
/// @name Accessing Document Formatters
///------------------------------------

/**
 The formatter used to determine `numberValue` for elements in the document. By default, this is an `NSNumberFormatter` instance with `NSNumberFormatterDecimalStyle`.
 */
@property (readonly, nonatomic, strong) NSNumberFormatter *numberFormatter;

/**
 The formatter used to determine `dateValue` for elements in the document. By default, this is an `NSDateFormatter` instance configured to accept ISO 8601 formatted timestamps.
 
 @see http://en.wikipedia.org/wiki/ISO_8601
 */
@property (readonly, nonatomic, strong) NSDateFormatter *dateFormatter;

///-----------------------------
/// @name Creating XML Documents
///-----------------------------

/**
 Creates and returns an instance of ONOXMLDocument from an XML string.
 
 @param string The XML string.
 @param encoding The string encoding.
 @param error The error error that occured while parsing the XML, or `nil`.
 
 @return An `ONOXMLDocument` with the contents of the specified XML string.
 */
+ (instancetype)XMLDocumentWithString:(NSString *)string
                             encoding:(NSStringEncoding)encoding
                                error:(NSError * __autoreleasing *)error;

/**
 Creates and returns an instance of ONOXMLDocument from XML data.

 @param data The XML data.
 @param error The error error that occured while parsing the XML, or `nil`.

 @return An `ONOXMLDocument` with the contents of the specified XML data.
 */
+ (instancetype)XMLDocumentWithData:(NSData *)data
                              error:(NSError * __autoreleasing *)error;

///------------------------------
/// @name Creating HTML Documents
///------------------------------

/**
 Creates and returns an instance of ONOXMLDocument from an HTML string.

 @param string The HTML string.
 @param encoding The string encoding.
 @param error The error error that occured while parsing the HTML, or `nil`.

 @return An `ONOXMLDocument` with the contents of the specified HTML string.
 */
+ (instancetype)HTMLDocumentWithString:(NSString *)string
                              encoding:(NSStringEncoding)encoding
                                 error:(NSError * __autoreleasing *)error;

/**
 Creates and returns an instance of ONOXMLDocument from HTML data.

 @param data The HTML string.
 @param error The error error that occured while parsing the HTML, or `nil`.

 @return An `ONOXMLDocument` with the contents of the specified HTML string.
 */
+ (instancetype)HTMLDocumentWithData:(NSData *)data
                               error:(NSError * __autoreleasing *)error;

///------------------------------------------
/// @name Defining Default Namespace Prefixes
///------------------------------------------

/**
 Define a prefix for a default namespace.
 
 @param prefix The prefix name
 @param ns The default namespace URI that declared in XML Document
 */
- (void)definePrefix:(NSString *)prefix
 forDefaultNamespace:(NSString *)ns;

@end

#pragma mark -

/**
 `ONOXMLElement` represents an element in an `ONOXMLDocument`.
 */
@interface ONOXMLElement : NSObject <ONOSearching, NSCopying, NSCoding>

/**
 The document containing the element.
 */
@property (readonly, nonatomic, weak) ONOXMLDocument *document;

/**
 The element's namespace.
 */
#ifdef __cplusplus
@property (readonly, nonatomic, copy) NSString *ns;
#else
@property (readonly, nonatomic, copy) NSString *namespace;
#endif

/**
 The element's tag.
 */
@property (readonly, nonatomic, copy) NSString *tag;

/**
 The element's line number
 */
@property (readonly, nonatomic, assign) NSUInteger lineNumber;

///---------------------------
/// @name Accessing Attributes
///---------------------------

/**
 All attributes for the element.
 */
@property (readonly, nonatomic, strong) NSDictionary *attributes;

/**
 Returns the value for the specified attribute.
 
 @param attribute The attribute name.
 
 @return The associated value.
 */
- (id)valueForAttribute:(NSString *)attribute;

/**
 Returns the value for an attribute in a particular namespace.

 @param attribute The attribute name.
 @param ns The attribute namespace.

 @return The associated value.
 */
- (id)valueForAttribute:(NSString *)attribute
            inNamespace:(NSString *)ns;

///----------------------------------------------------
/// @name Accessing Parent, Child, and Sibling Elements
///----------------------------------------------------

/**
 The element's parent element.
 */
@property (readonly, nonatomic, strong) ONOXMLElement *parent;

/**
 The element's children elements.
 */
@property (readonly, nonatomic, strong) NSArray *children;

/**
 The element's previous sibling.
 */
@property (readonly, nonatomic, strong) ONOXMLElement *previousSibling;

/**
 The element's next sibling.
 */
@property (readonly, nonatomic, strong) ONOXMLElement *nextSibling;

/**
 Returns the first child element with the specified tag, or `nil` if no such element exists.
 
 @param tag The tag name.
 
 @return The child element.
 */
- (ONOXMLElement *)firstChildWithTag:(NSString *)tag;

/**
 Returns the first child element with a tag in a particular namespace, or `nil` if no such element exists.

 @param tag The tag name.
 @param ns The namespace.

 @return The child element.
 */
- (ONOXMLElement *)firstChildWithTag:(NSString *)tag
                         inNamespace:(NSString *)ns;

/**
 Returns all children elements with the specified tag.

 @param tag The tag name.

 @return The children elements.
 */
- (NSArray *)childrenWithTag:(NSString *)tag;

/**
 Returns all children elements with the specified tag.

 @param tag The tag name.
 @param ns The namepsace.

 @return The children elements.
 */
- (NSArray *)childrenWithTag:(NSString *)tag
                 inNamespace:(NSString *)ns;

///------------------------
/// @name Accessing Content
///------------------------

/**
 Whether the element has a value.
 */
@property (readonly, nonatomic, assign, getter = isBlank) BOOL blank;

/**
 A string representation of the element's value.
 
 @return The string value.
 */
- (NSString *)stringValue;

/**
 A number representation of the element's value, which is generated from the document's `numberFormatter` property.
 
 @return The number value;
 */
- (NSNumber *)numberValue;

/**
 A date representation of the element's value, which is generated from the document's `dateFormatter` property.
 
 @return The date value.
 */
- (NSDate *)dateValue;

///--------------------------------------
/// @name Subscripted Convenience Methods
///--------------------------------------

/**
 Returns the child element at the specified index.
 
 @param idx The index.
 
 @return The child element.
 */
- (id)objectAtIndexedSubscript:(NSUInteger)idx;

/**
 Returns the value for the attribute with the specified key.
 
 @param key The key.
 
 @return The attribute value, or `nil` if the attribute is not defined.
 */
- (id)objectForKeyedSubscript:(id)key;

@end

/**
 `ONOXPathFunctionResult` represents a XPath function result in an `ONOXPathFunctionResult`.
 */
@interface ONOXPathFunctionResult : NSObject

/**
 represents `boolval` in `xmlXPathObject`
 */
@property (readonly, nonatomic) BOOL boolValue;

/**
 represents `floatval` in `xmlXPathObject`
 */
@property (readonly, nonatomic) double numericValue;

/**
 represents `stringval` in `xmlXPathObject`
 */
@property (readonly, nonatomic, copy) NSString *stringValue;

@end

///---------------------------
/// @name Constants
///---------------------------

/**
 ## Error Domains

 The following error domain is predefined.

 - `NSString * const ONOErrorDomain`

 ### Constants

 `ONOErrorDomain`
 Ono errors. Error codes for `ONOErrorDomain` are not currently defined.
 */
extern NSString * const ONOErrorDomain;
