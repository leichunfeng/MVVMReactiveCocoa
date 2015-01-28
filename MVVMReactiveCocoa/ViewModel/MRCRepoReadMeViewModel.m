//
//  MRCRepoReadMeViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/26.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepoReadMeViewModel.h"
#import "MRCRepositoryService.h"

@interface MRCRepoReadMeViewModel ()

@property (strong, nonatomic) OCTRepository *repository;

@end

@implementation MRCRepoReadMeViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(id)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.repository = params[@"repository"];
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    @weakify(self)
    [[[self.services getRepositoryService]
     	requestRepositoryReadmeRenderedHTML:self.repository]
    	subscribeNext:^(NSString *htmlString) {
            @strongify(self)
            self.title = @"";
            self.attributedString = [self attributedStringFromHTMLString:htmlString];
        }];
}

- (NSAttributedString *)attributedStringFromHTMLString:(NSString *)htmlString {
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    // example for setting a willFlushCallback, that gets called before elements are written to the generated attributed string
    void (^callBackBlock)(DTHTMLElement *element) = ^(DTHTMLElement *element) {
        // the block is being called for an entire paragraph, so we check the individual elements
        for (DTHTMLElement *oneChildElement in element.childNodes) {
            // if an element is larger than twice the font size put it in it's own block
            if (oneChildElement.displayStyle == DTHTMLElementDisplayStyleInline && oneChildElement.textAttachment.displaySize.height > 2.0 * oneChildElement.fontDescriptor.pointSize) {
                oneChildElement.displayStyle = DTHTMLElementDisplayStyleBlock;
                oneChildElement.paragraphStyle.minimumLineHeight = element.textAttachment.displaySize.height;
                oneChildElement.paragraphStyle.maximumLineHeight = element.textAttachment.displaySize.height;
            }
        }
    };
    
    NSMutableDictionary *options = [NSMutableDictionary dictionaryWithObjectsAndKeys:@1, NSTextSizeMultiplierDocumentOption, @"Times New Roman", DTDefaultFontFamily, @"purple", DTDefaultLinkColor, @"red", DTDefaultLinkHighlightColor, callBackBlock, DTWillFlushBlockCallBack, @17, DTDefaultFontSize, nil];
    
    NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:options documentAttributes:NULL];
    
    return string;
}

@end
