//
//  MRCSettingsViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/3/4.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCSettingsViewController.h"
#import "MRCSettingsViewModel.h"
#import "MRCWebViewModel.h"

@interface MRCSettingsViewController ()

@property (nonatomic, strong, readonly) MRCSettingsViewModel *viewModel;

@end

@implementation MRCSettingsViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel.adURL = MRCSharedAppDelegate.adURL;
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) return [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    return [super tableView:tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
    if (indexPath.section == 0) {
        cell.textLabel.text = @"My Account";
        cell.detailTextLabel.text = [SSKeychain rawLogin];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"About";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if (indexPath.row == 1) {
            if (self.viewModel.adURL.length == 0) cell.hidden = YES;
            
            cell.textLabel.text = @"Advertisement";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    } else if (indexPath.section == 2) {
        cell.textLabel.text = @"Log Out";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    [cell.rac_prepareForReuseSignal subscribeNext:^(id x) {
        cell.hidden = NO;
        cell.detailTextLabel.text = nil;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 1 ? 2 : 1;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 20 : 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return (section == tableView.numberOfSections - 1) ? 20 : 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 1 && self.viewModel.adURL.length == 0) return 0;
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 1) {
        NSString *adURL = [self.viewModel.adURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:adURL]];
        MRCWebViewModel *webViewModel = [[MRCWebViewModel alloc] initWithServices:self.viewModel.services
                                                                           params:@{ @"title": @"爱淘宝",
                                                                                     @"request": request }];
        [self.viewModel.services pushViewModel:webViewModel animated:YES];
    } else if (indexPath.section == 2) {
        NSString *message = @"Logout will not delete any data. You can still log in with this account.";
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:message
                                                                          preferredStyle:UIAlertControllerStyleActionSheet];
        @weakify(self)
        [alertController addAction:[UIAlertAction actionWithTitle:@"Log Out" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            @strongify(self)
            [self.viewModel.logoutCommand execute:nil];
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:NULL]];
        
        alertController.popoverPresentationController.sourceView = [tableView cellForRowAtIndexPath:indexPath];
        alertController.popoverPresentationController.sourceRect = [tableView cellForRowAtIndexPath:indexPath].bounds;
        
        [self presentViewController:alertController animated:YES completion:NULL];
    }
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

@end
