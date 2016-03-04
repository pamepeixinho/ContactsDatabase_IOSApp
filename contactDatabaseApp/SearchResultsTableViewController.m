//
//  SearchResultsTableViewController.m
//  contactDatabaseApp
//
//  Created by Pamela Iupi Peixinho on 3/3/16.
//  Copyright © 2016 PamelaPeixinho. All rights reserved.
//

#import "SearchResultsTableViewController.h"
#import "DetailViewController.h"

@interface SearchResultsTableViewController ()

@end

@implementation SearchResultsTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return _searchResults.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UITableViewCell *cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    NSManagedObjectModel *thisContact = [_searchResults objectAtIndex:indexPath.row];
    [self configureCell:cell forObject:thisContact];
    
    return cell;
}

@end
