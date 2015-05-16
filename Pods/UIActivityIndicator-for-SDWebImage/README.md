UIActivityIndicator-for-SDWebImage
==================================

The easiest way to add a UIActivityView to your [SDWebImage](https://github.com/rs/SDWebImage) view


Installation
-----------

If you're using  [CocoaPods](http://cocoapods.org) (You are not?! You should!!) just add 
    
    pod 'UIActivityIndicator-for-SDWebImage'
into your Podfile file.

Alternatively, copy the class (.h and .m) into your application. 


Usage
-----------

You can use all the standard SDWebImage methods... adding the last parameter

    usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle 

So all the methods available are:
 
    - (void)setImageWithURL:(NSURL *)url usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle;
	- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle;
	- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle;
	- (void)setImageWithURL:(NSURL *)url completed:(SDWebImageCompletionBlock)completedBlock usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle;
	- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle;
	- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletionBlock)completedBlock usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle;
	- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle;



**Remove the activity indicator**

Sometimes it's useful to remove the activity indicator (for example when you call `cancelCurrentImageLoad` on the UIImageView). 
From now on the method `removeActivityIndicator` is public: fell free to use it! 


Why?
-----------

Well, apparently SDWebImage team [doesn't want](https://github.com/rs/SDWebImage/pull/131) a UIActivityIndicatorView... (actually I found a bug in that commit, but I don't think this is why they closed the issue)

**Why?** I don't know. 

**And why a category instead of a fork?** Well, I really don't want to keep this repo updated with the (future) new SDWebImage commits (obvious, right?).  

**Ok, but  we could modify our SDWebImage repo with these differences** Yes... unless you're using Cocoapods! If you're doing it you should know that you can't modify a repo, because at the next update, Cocoapods will delete all your work (pulling the new version and removing all your changes). So with a category you can keep your SDWebImage pod updated without problems :) 


License
-------

UIActivityView for SDWebImage is released under the MIT License. Please see the LICENSE file for details.