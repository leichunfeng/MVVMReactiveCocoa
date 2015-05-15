# Vertigo
**Vertigo** is a simple image viewer which includes a **custom view controller transition** that mimics the new **iOS 7 Photos app** image zoom transition effect.
<p align="center" >
<img src="https://raw.github.com/gonzalezreal/Vertigo/master/VertigoSample/VertigoSample.gif" alt="Image zoom transition" width="318" height="566" />
</p>

## Installation
### From CocoaPods
Add `pod 'Vertigo'` to your Podfile.
### Manually
Drag the `Vertigo` folder into your project. If your project doesn't use ARC you must enable it for all the `.m` files under the `Vertigo` folder.

## Usage
**Vertigo** includes the following classes:
* `TGRImageViewController` is the image viewer itself. The user can double tap on the image to zoom it in or out. A single tap will dismiss the viewer.
* `TGRImageZoomAnimationController` is the object that performs the custom transition between your view controller and a `TGRImageViewController` (that is, the **Photos app** image zoom transition effect).

To present and dismiss a `TGRImageViewController` from your view controller using the custom transition effect, your view controller needs to implement the new `UIViewControllerTransitioningDelegate` protocol and return a `TGRImageZoomAnimationController` initialized with the image view that will be used as the inital (or final in case of dismissal) point of the transition.
```objc
#import "TGRImageViewController.h"
#import "TGRImageZoomAnimationController.h"

@interface MyViewController () <UIViewControllerTransitioningDelegate>
@end

@implementation MyViewController
...
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    if ([presented isKindOfClass:TGRImageViewController.class]) {
        return [[TGRImageZoomAnimationController alloc] initWithReferenceImageView:self.imageView];
    }
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if ([dismissed isKindOfClass:TGRImageViewController.class]) {
        return [[TGRImageZoomAnimationController alloc] initWithReferenceImageView:self.imageView];
    }
    return nil;
}

- (IBAction)showImageViewer {
    TGRImageViewController *viewController = [[TGRImageViewController alloc] initWithImage:self.imageView.image];
    // Don't forget to set ourselves as the transition delegate
    viewController.transitioningDelegate = self;
    
    [self presentViewController:viewController animated:YES completion:nil];
}
```

## Contact
[Guillermo Gonzalez](http://github.com/gonzalezreal)  
[@gonzalezreal](https://twitter.com/gonzalezreal)
## License
Vertigo is available under the MIT license. See [LICENSE](https://github.com/gonzalezreal/Vertigo/blob/master/LICENSE).
