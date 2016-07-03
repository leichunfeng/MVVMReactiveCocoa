OcticonsIOS
===========

A library for easily adding GitHub's [Octicons](https://github.com/blog/1106-say-hello-to-octicons) to your iOS projects.

This project is heavily based on [ios-fontawesome](https://github.com/alexdrone/ios-fontawesome).

It uses the Octicon icons which are distributed under the Apache license with the [GitHub Android app](https://github.com/github/android/).


Examples
--------

```Objective-C

	UIImage *image = [UIImage octicon_imageWithIcon:@"GitPullRequest"
                                        backgroundColor:[UIColor whiteColor]
                                              iconColor:[UIColor darkGrayColor]
                                              iconScale:1.0
                                                andSize:CGSizeMake(150.0F, 150.0F)];
```

Installation 
------------

The easiest way to install OcticonsIOS is with [CocoaPods](http://cocoapods.org). Just add the following to your Podfile:

    pod 'OcticonsIOS', '~> 0.0.2'

    
