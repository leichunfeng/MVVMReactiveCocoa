//
//  MRCRepoDetailViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepoDetailViewModel.h"
#import "MRCRepositoryService.h"
#import "MRCSelectBranchOrTagViewModel.h"
#import "MRCGitTreeViewModel.h"
#import "MRCSourceEditorViewModel.h"
#import "TTTTimeIntervalFormatter.h"
#import "MRCRepoSettingsViewModel.h"

@interface MRCRepoDetailViewModel ()

@property (nonatomic, strong, readwrite) OCTRepository *repository;

@property (nonatomic, copy, readwrite) NSArray *references;
@property (nonatomic, strong, readwrite) OCTRef *reference;

@property (nonatomic, copy, readwrite) NSString *dateUpdated;
@property (nonatomic, copy, readwrite) NSString *summaryReadmeHTML;

@property (nonatomic, strong, readwrite) RACCommand *viewCodeCommand;
@property (nonatomic, strong, readwrite) RACCommand *readmeCommand;
@property (nonatomic, strong, readwrite) RACCommand *selectBranchOrTagCommand;
@property (nonatomic, strong, readwrite) RACCommand *rightBarButtonItemCommand;

@property (nonatomic, copy) NSString *referenceName;

@end

@implementation MRCRepoDetailViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(NSDictionary *)params {
    self = [super initWithServices:services params:params];
    if (self) {
        id repository = params[@"repository"];

        if ([repository isKindOfClass:[OCTRepository class]]) {
            self.repository = params[@"repository"];
        } else if ([repository isKindOfClass:[NSDictionary class]]) {
            self.repository = [OCTRepository modelWithDictionary:repository error:nil];
        }
        
        NSParameterAssert(self.repository);

        self.referenceName = params[@"referenceName"] ?: MRCReferenceNameWithBranchName(self.repository.defaultBranch);
        
        NSParameterAssert(self.referenceName);
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    self.shouldPullToRefresh = YES;
    
    self.titleViewType = MRCTitleViewTypeDoubleTitle;
    self.title = self.repository.name;
    self.subtitle = self.repository.ownerLogin;

    NSError *error = nil;
    self.reference = [[OCTRef alloc] initWithDictionary:@{ @"name": self.referenceName } error:&error];
    if (error) MRCLogError(error);
    
    TTTTimeIntervalFormatter *timeIntervalFormatter = [[TTTTimeIntervalFormatter alloc] init];
    timeIntervalFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    RAC(self, dateUpdated) = [[RACObserve(self.repository, dateUpdated) ignore:nil] map:^id(NSDate *dateUpdated) {
        return [NSString stringWithFormat:@"Updated %@", [timeIntervalFormatter stringForTimeIntervalFromDate:NSDate.date toDate:dateUpdated]];
    }];
    
    @weakify(self)
    self.viewCodeCommand = [[RACCommand alloc] initWithSignalBlock:^(id input) {
        @strongify(self)
        MRCGitTreeViewModel *gitTreeViewModel = [[MRCGitTreeViewModel alloc] initWithServices:self.services
                                                                                       params:@{ @"repository": self.repository,
                                                                                                 @"reference": self.reference }];
        [self.services pushViewModel:gitTreeViewModel animated:YES];
        return [RACSignal empty];
    }];
    
    self.readmeCommand = [[RACCommand alloc] initWithSignalBlock:^(id input) {
        @strongify(self)
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        
        [params setValue:@"README.md" forKey:@"title"];
        [params setValue:self.repository forKey:@"repository"];
        [params setValue:self.reference forKey:@"reference"];
        [params setValue:@(MRCSourceEditorViewModelEntryRepoDetail) forKey:@"entry"];
        
        MRCSourceEditorViewModel *sourceEditorViewModel = [[MRCSourceEditorViewModel alloc] initWithServices:self.services params:params.copy];
        [self.services pushViewModel:sourceEditorViewModel animated:YES];
        
        return [RACSignal empty];
    }];
    
    self.selectBranchOrTagCommand = [[RACCommand alloc] initWithSignalBlock:^(id input) {
        @strongify(self)
        if (self.references) {
            [self presentSelectBranchOrTagViewModel];
            return [RACSignal empty];
        } else {
            return [[[[self.services.client
            	fetchAllReferencesInRepository:self.repository]
             	collect]
                doNext:^(NSArray *references) {
                    @strongify(self)
                    self.references = references;
                    [self presentSelectBranchOrTagViewModel];
                }]
            	takeUntil:self.willDisappearSignal];
        }
    }];
    
    [self.selectBranchOrTagCommand.errors subscribe:self.errors];
    
    self.rightBarButtonItemCommand = [[RACCommand alloc] initWithSignalBlock:^(id input) {
        @strongify(self)
        MRCRepoSettingsViewModel *settingsViewModel = [[MRCRepoSettingsViewModel alloc] initWithServices:self.services
                                                                                                  params:@{ @"repository": self.repository }];
        [self.services pushViewModel:settingsViewModel animated:YES];
        return [RACSignal empty];
    }];
    
    RACSignal *fetchLocalDataSignal = [RACSignal return:[self fetchLocalData]];
    RACSignal *requestRemoteDataSignal = self.requestRemoteDataCommand.executionSignals.switchToLatest;
    
    [[[fetchLocalDataSignal
    	merge:requestRemoteDataSignal]
     	deliverOnMainThread]
    	subscribeNext:^(OCTRepository *repository) {
            @strongify(self)
            
            [self willChangeValueForKey:@"repository"];
            
            repository.starredStatus = self.repository.starredStatus;
            [self.repository mergeValuesForKeysFromModel:repository];
            
            [self didChangeValueForKey:@"repository"];
        }];
    
    NSString *HTMLString = (NSString *)[[YYCache sharedCache] objectForKey:[self cacheKeyForReadmeOfMediaType:OCTClientMediaTypeHTML]];
    self.summaryReadmeHTML = [self summaryReadmeHTMLFromReadmeHTML:HTMLString];
}

- (OCTRepository *)fetchLocalData {
    return [OCTRepository mrc_fetchRepository:self.repository];
}

- (NSString *)cacheKeyForReadmeOfMediaType:(OCTClientMediaType)mediaType {
    return [NSString stringWithFormat:@"repos/%@/%@/readme?ref=%@&accept=%@", self.repository.ownerLogin, self.repository.name, self.reference.name, @(mediaType)];
}

- (void)presentSelectBranchOrTagViewModel {
    NSDictionary *params = @{ @"references": self.references, @"selectedReference": self.reference };
    MRCSelectBranchOrTagViewModel *branchViewModel = [[MRCSelectBranchOrTagViewModel alloc] initWithServices:self.services params:params];
    
    @weakify(self)
    branchViewModel.callback = ^(OCTRef *reference) {
        @strongify(self)
        self.reference = reference;
        [self.requestRemoteDataCommand execute:nil];
    };
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.services presentViewModel:branchViewModel animated:YES completion:NULL];
    });
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    RACSignal *fetchRepoSignal = [self.services.client fetchRepositoryWithName:self.repository.name
                                                                         owner:self.repository.ownerLogin];
    
    RACSignal *fetchReadmeSignal = [[self.services client] fetchRepositoryReadme:self.repository
                                                                       reference:self.reference.name
                                                                       mediaType:OCTClientMediaTypeHTML];

    @weakify(self)
    return [[[[RACSignal
        combineLatest:@[ fetchRepoSignal, fetchReadmeSignal ]]
        doNext:^(RACTuple *tuple) {
            @strongify(self)
            
            self.summaryReadmeHTML = [self summaryReadmeHTMLFromReadmeHTML:tuple.last];
            
            [[YYCache sharedCache] setObject:tuple.last
                                      forKey:[self cacheKeyForReadmeOfMediaType:OCTClientMediaTypeHTML]
                                   withBlock:NULL];
        }]
        map:^(RACTuple *tuple) {
            return tuple.first;
        }]
    	doNext:^(OCTRepository *repo) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [repo mrc_saveOrUpdate];
            });
        }];
}

- (NSString *)summaryReadmeHTMLFromReadmeHTML:(NSString *)readmeHTML {
    __block NSString *summaryReadmeHTML = MRC_README_CSS_STYLE;
    
    NSError *error = nil;
    ONOXMLDocument *document = [ONOXMLDocument HTMLDocumentWithString:readmeHTML encoding:NSUTF8StringEncoding error:&error];
    if (error != nil) MRCLogError(error);
    
    NSString *XPath = @"//article/*";
    [document enumerateElementsWithXPath:XPath usingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *stop) {
        if (idx < 3) summaryReadmeHTML = [summaryReadmeHTML stringByAppendingString:element.description];
    }];
    
    // Not find the `article` element
    // So we try to search the element that match `id="readme"` instead
    if ([summaryReadmeHTML isEqualToString:MRC_README_CSS_STYLE]) {
        NSString *CSS = @"div#readme";
        [document enumerateElementsWithCSS:CSS usingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *stop) {
            if (idx < 3) summaryReadmeHTML = [summaryReadmeHTML stringByAppendingString:element.description];
        }];
    }
    
    return summaryReadmeHTML;
}

@end
