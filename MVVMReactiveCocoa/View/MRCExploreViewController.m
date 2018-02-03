//
//  MRCExploreViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/3/26.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "MRCExploreViewController.h"
#import "MRCExploreViewModel.h"
#import "MRCExploreTableViewCell.h"
#import "MRCReposSearchResultsViewController.h"
#import "MRCSearchBar.h"
#import "LCFInfiniteScrollView.h"
#import "SDVersion.h"
#import "MRCShowcaseReposViewModel.h"

@interface MRCExploreViewController () <UISearchBarDelegate, UISearchControllerDelegate>

@property (nonatomic, strong) MRCExploreViewModel *viewModel;

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) MRCReposSearchResultsViewController *searchResultsController;
@property (nonatomic, strong) UIButton *switchLanguageButton;

@end

@implementation MRCExploreViewController

@dynamic viewModel;

- (void)viewDidLoad {
    if ([SDVersion deviceSize] == Screen3Dot5inch ||
        [SDVersion deviceSize] == Screen4inch) {
        self.viewModel.itemSize = CGSizeMake(640.0 / 2, 260.0 / 2);
        self.viewModel.itemSpacing = 0;
    } else if ([SDVersion deviceSize] == Screen4Dot7inch) {
        self.viewModel.itemSize = CGSizeMake(750.0 / 2, 304.0 / 2);
        self.viewModel.itemSpacing = 0;
    } else if ([SDVersion deviceSize] == Screen5Dot5inch) {
        self.viewModel.itemSize = CGSizeMake(796.0 / 3, 390.0 / 3);
        self.viewModel.itemSpacing = 5;
    } else {
        if (iPhoneX) {
            self.viewModel.itemSize = CGSizeMake(750.0 / 2, 304.0 / 2);
            self.viewModel.itemSpacing = 0;
        } else {
            self.viewModel.itemSize = CGSizeMake(1060.0 / 2, 520.0 / 2);
            self.viewModel.itemSpacing = 5;
        }
    }

    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"MRCExploreTableViewCell" bundle:nil] forCellReuseIdentifier:@"MRCExploreTableViewCell"];
    self.tableView.showsVerticalScrollIndicator = NO;

    self.searchResultsController = [[MRCReposSearchResultsViewController alloc] initWithViewModel:self.viewModel.searchResultsViewModel];

    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultsController];
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.delegate = self;

    MRCSearchBar *searchBar = [[MRCSearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44)];
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    [self.searchController setValue:searchBar forKey:@"searchBar"];
    
    RAC(searchBar, placeholder) = [RACObserve(self.viewModel.searchResultsViewModel, language) map:^(NSDictionary *language) {
        return [NSString stringWithFormat:@"Search for %@", language[@"name"]];
    }];
    
    self.switchLanguageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBar addSubview:self.switchLanguageButton];
    if (IOS11) {
        self.switchLanguageButton.frame = CGRectMake(17, 13, 28, 28);
    } else {
        self.switchLanguageButton.frame = CGRectMake(0, 8, 28, 28);
    }
    self.switchLanguageButton.backgroundColor = [UIColor whiteColor];
    self.switchLanguageButton.hidden = YES;
    
    self.switchLanguageButton.layer.cornerRadius  = 5;
    self.switchLanguageButton.layer.masksToBounds = YES;
    
    [self.switchLanguageButton setImage:[UIImage octicon_imageWithIdentifier:@"TriangleDown" size:CGSizeMake(13, 13)]
            forState:UIControlStateNormal];
    
    self.switchLanguageButton.rac_command = self.viewModel.switchLanguageCommand;
    
    self.definesPresentationContext = YES;

    CGFloat scrollViewY = iPhoneX ? 88 : 64;
    LCFInfiniteScrollView *infiniteScrollView = [[LCFInfiniteScrollView alloc] initWithFrame:CGRectMake(0, scrollViewY, CGRectGetWidth(self.view.frame), self.viewModel.itemSize.height)];
    [self.view addSubview:infiniteScrollView];
    
    infiniteScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    infiniteScrollView.itemSize = self.viewModel.itemSize;
    infiniteScrollView.itemSpacing = self.viewModel.itemSpacing;

    RAC(infiniteScrollView, items) = [RACObserve(self.viewModel, showcases) map:^(NSArray *showcases) {
        return [showcases.rac_sequence map:^(NSDictionary *showcase) {
            return [LCFInfiniteScrollViewItem itemWithImageURL:showcase[@"image_url"] text:showcase[@"name"]];
        }].array;
    }];

    @weakify(self)
    RAC(infiniteScrollView, frame) = [RACObserve(self.tableView, contentOffset) map:^(NSValue *contentOffset) {
        CGFloat width  = CGRectGetWidth(infiniteScrollView.frame);
        CGFloat height = CGRectGetHeight(infiniteScrollView.frame);
        
        CGFloat deltaY = contentOffset.CGPointValue.y - (-(scrollViewY + height));
       
        if (deltaY <= 0) {
            return [NSValue valueWithCGRect:CGRectMake(0, scrollViewY, width, height)];
        } else {
            return [NSValue valueWithCGRect:CGRectMake(0, scrollViewY - deltaY, width, height)];
        }
    }];
    
    infiniteScrollView.didSelectItemAtIndex = ^(NSUInteger index) {
        @strongify(self)
        MRCShowcaseReposViewModel *viewModel = [[MRCShowcaseReposViewModel alloc] initWithServices:self.viewModel.services
                                                                                            params:@{ @"showcase": self.viewModel.showcases[index] ?: [NSNull null] }];
        [self.viewModel.services pushViewModel:viewModel animated:YES];
    };
}

- (UIEdgeInsets)contentInset {
    return iPhoneX ? UIEdgeInsetsMake(88 + self.viewModel.itemSize.height, 0, 83, 0) : UIEdgeInsetsMake(64 + self.viewModel.itemSize.height, 0, 49, 0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"MRCExploreTableViewCell" forIndexPath:indexPath];
}

- (void)configureCell:(MRCExploreTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(MRCExploreItemViewModel *)viewModel {
    [cell bindViewModel:viewModel];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 168;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.searchController.active = YES;
    self.switchLanguageButton.hidden = NO;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.viewModel.searchResultsViewModel.dataSource = @[];
    self.viewModel.searchResultsViewModel.query = searchText;
    self.searchController.view.subviews.firstObject.subviews.firstObject.hidden = (searchText.length == 0);
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    if (searchBar.text.length == 0) {
        self.switchLanguageButton.hidden = YES;
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (searchBar.text.length > 0) {
        self.viewModel.searchResultsViewModel.dataSource = @[];
        [searchBar resignFirstResponder];
        [self.viewModel.searchResultsViewModel.requestRemoteDataCommand execute:nil];
    }
}

@end
