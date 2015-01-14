//
//  MRCTableViewController.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/27.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#import "MRCViewController.h"

@interface MRCTableViewController : MRCViewController <UITableViewDataSource, UITableViewDelegate>

// The table view for tableView controller.
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
