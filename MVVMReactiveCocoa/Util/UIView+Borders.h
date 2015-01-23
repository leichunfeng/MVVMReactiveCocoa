//
//  UIView+Borders.h
//
//  Created by Aaron Ng on 12/28/13.
//  Copyright (c) 2013 Delve. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Borders)

/* Create your borders and assign them to a property on a view when you can via the create methods when possible. Otherwise you might end up with multiple borders being created.
 */

///------------
/// Top Border
///------------
-(CALayer*)createTopBorderWithHeight: (CGFloat)height andColor:(UIColor*)color;
-(UIView*)createViewBackedTopBorderWithHeight: (CGFloat)height andColor:(UIColor*)color;
-(void)addTopBorderWithHeight:(CGFloat)height andColor:(UIColor*)color;
-(void)addViewBackedTopBorderWithHeight:(CGFloat)height andColor:(UIColor*)color;


///------------
/// Top Border + Offsets
///------------

-(CALayer*)createTopBorderWithHeight: (CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andTopOffset:(CGFloat)topOffset;
-(UIView*)createViewBackedTopBorderWithHeight: (CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andTopOffset:(CGFloat)topOffset;
-(void)addTopBorderWithHeight: (CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andTopOffset:(CGFloat)topOffset;
-(void)addViewBackedTopBorderWithHeight: (CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andTopOffset:(CGFloat)topOffset;

///------------
/// Right Border
///------------

-(CALayer*)createRightBorderWithWidth: (CGFloat)width andColor:(UIColor*)color;
-(UIView*)createViewBackedRightBorderWithWidth: (CGFloat)width andColor:(UIColor*)color;
-(void)addRightBorderWithWidth: (CGFloat)width andColor:(UIColor*)color;
-(void)addViewBackedRightBorderWithWidth: (CGFloat)width andColor:(UIColor*)color;

///------------
/// Right Border + Offsets
///------------

-(CALayer*)createRightBorderWithWidth: (CGFloat)width color:(UIColor*)color rightOffset:(CGFloat)rightOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset;
-(UIView*)createViewBackedRightBorderWithWidth: (CGFloat)width color:(UIColor*)color rightOffset:(CGFloat)rightOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset;
-(void)addRightBorderWithWidth: (CGFloat)width color:(UIColor*)color rightOffset:(CGFloat)rightOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset;
-(void)addViewBackedRightBorderWithWidth: (CGFloat)width color:(UIColor*)color rightOffset:(CGFloat)rightOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset;

///------------
/// Bottom Border
///------------

-(CALayer*)createBottomBorderWithHeight: (CGFloat)height andColor:(UIColor*)color;
-(UIView*)createViewBackedBottomBorderWithHeight: (CGFloat)height andColor:(UIColor*)color;
-(void)addBottomBorderWithHeight:(CGFloat)height andColor:(UIColor*)color;
-(void)addViewBackedBottomBorderWithHeight:(CGFloat)height andColor:(UIColor*)color;

///------------
/// Bottom Border + Offsets
///------------

-(CALayer*)createBottomBorderWithHeight: (CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andBottomOffset:(CGFloat)bottomOffset;
-(UIView*)createViewBackedBottomBorderWithHeight: (CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andBottomOffset:(CGFloat)bottomOffset;
-(void)addBottomBorderWithHeight: (CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andBottomOffset:(CGFloat)bottomOffset;
-(void)addViewBackedBottomBorderWithHeight: (CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andBottomOffset:(CGFloat)bottomOffset;

///------------
/// Left Border
///------------

-(CALayer*)createLeftBorderWithWidth: (CGFloat)width andColor:(UIColor*)color;
-(UIView*)createViewBackedLeftBorderWithWidth: (CGFloat)width andColor:(UIColor*)color;
-(void)addLeftBorderWithWidth: (CGFloat)width andColor:(UIColor*)color;
-(void)addViewBackedLeftBorderWithWidth: (CGFloat)width andColor:(UIColor*)color;

///------------
/// Left Border + Offsets
///------------

-(CALayer*)createLeftBorderWithWidth: (CGFloat)width color:(UIColor*)color leftOffset:(CGFloat)leftOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset;
-(UIView*)createViewBackedLeftBorderWithWidth: (CGFloat)width color:(UIColor*)color leftOffset:(CGFloat)leftOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset;
-(void)addLeftBorderWithWidth: (CGFloat)width color:(UIColor*)color leftOffset:(CGFloat)leftOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset;
-(void)addViewBackedLeftBorderWithWidth: (CGFloat)width color:(UIColor*)color leftOffset:(CGFloat)leftOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset;

@end
