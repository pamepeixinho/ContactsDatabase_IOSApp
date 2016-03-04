//
//  TableViewController.h
//  contactDatabaseApp
//
//  Created by Pamela Iupi Peixinho on 2/15/16.
//  Copyright © 2016 PamelaPeixinho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResultsTableViewController.h"
#import "BaseTableViewController.h"
#import "DetailViewController.h"

@interface TableViewController : BaseTableViewController
//<UISearchResultsUpdating>


@property (strong, nonatomic) NSMutableArray *contacts;

@property (strong, nonatomic) NSMutableArray *searchResults;

@end
