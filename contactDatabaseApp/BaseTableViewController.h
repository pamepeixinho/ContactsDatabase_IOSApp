//
//  BaseTableViewController.h
//  contactDatabaseApp
//
//  Created by Pamela Iupi Peixinho on 3/3/16.
//  Copyright © 2016 PamelaPeixinho. All rights reserved.
//
//Abstract:
//Base or common view controller to share a common UITableViewCell prototype between subclasses.


#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

extern NSString *const kCellIdentifier;

@interface BaseTableViewController : UITableViewController

- (void)configureCell:(UITableViewCell *)cell forObject:(NSObject *)object;

@end
