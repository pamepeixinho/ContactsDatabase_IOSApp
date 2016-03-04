//
//  BaseTableViewController.m
//  contactDatabaseApp
//
//  Created by Pamela Iupi Peixinho on 3/3/16.
//  Copyright © 2016 PamelaPeixinho. All rights reserved.
//

#import "BaseTableViewController.h"

NSString *const kCellIdentifier = @"cellID";
NSString *const kTableCellNibName = @"cell";

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // we use a nib which contains the cell's view and this class as the files owner
    [self.tableView registerNib:[UINib nibWithNibName:kTableCellNibName bundle:nil] forCellReuseIdentifier:kCellIdentifier];

    self.tableView.backgroundColor = [UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:1.0];
    self.tableView.separatorColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:0.8];
    [self.tableView setSeparatorInset: UIEdgeInsetsMake(0, 15, 0, 15)];
    
}

-(void) configureCell:(UITableViewCell *)cell forObject:(NSManagedObjectModel *)nsObject{
 
//    NSLog(@"%@", [nsObject valueForKey:@"name"]);
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [nsObject valueForKey:@"name"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [nsObject valueForKey:@"mail"]];
}

@end
