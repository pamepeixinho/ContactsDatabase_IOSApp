//
//  TableViewController.m
//  contactDatabaseApp
//
//  Created by Pamela Iupi Peixinho on 2/15/16.
//  Copyright © 2016 PamelaPeixinho. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController () <UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>


@property (nonatomic, strong) UISearchController *searchController;

// our secondary search results table view
@property (nonatomic, strong) SearchResultsTableViewController *resultsTableController;

@end


@implementation TableViewController

//delegate managed object context
-(NSManagedObjectContext *) managedObjectContext{
    
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if([delegate performSelector:@selector(managedObjectContext)]){
        context = [delegate managedObjectContext];
    }
 
    return context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    
//----------- old code
//    UINavigationController *searchResultsController = [[self storyboard] instantiateViewControllerWithIdentifier:@"TableSearchResultsNavController"];
//    
//    _searchController = [[UISearchController alloc] initWithSearchResultsController: searchResultsController];
//    _searchController.searchResultsUpdater = self;
//    
//    [self.searchController.searchBar sizeToFit];
//    self.tableView.tableHeaderView = _searchController.searchBar;
// --------------------

    _resultsTableController = [[SearchResultsTableViewController alloc] init];
    _searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultsTableController];
    _searchController.searchResultsUpdater = self;
    [_searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
     // didSelectRowAtIndexPath is called for both tables
    _resultsTableController.tableView.delegate = self;
    _searchController.delegate = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.searchBar.delegate = self; //can monitor text changes + others
    self.definesPresentationContext = YES;// know where you want UISearchController to be displayed

    
}


// viewDidLoad só executa quando carrega a primeira vez
// viewWillAppear executa sempre que aparecer
// \/ neste caso, dar reload no context com base no banco de dados (coredata)
-(void) viewWillAppear:(BOOL)animated{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"ContactsData"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
     NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    [request setSortDescriptors:sortDescriptors];
    _contacts = [[context executeFetchRequest:request error:nil] mutableCopy];

    [self.tableView reloadData];
}


#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return _contacts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    NSManagedObjectModel *thisContact = [_contacts objectAtIndex:indexPath.row];
//        NSLog(@"%@", [thisContact valueForKey:@"name"]);
    [self configureCell:cell forObject:thisContact];

    return cell;
}

// here we are the table view delegate for both our main table and filtered table, so we can
// push from the current navigation controller (resultsTableController's parent view controller
// is not this UINavigationController)
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//  identifier which tableview is
    NSManagedObjectModel *selectedContact = (self.tableView == tableView) ?
    [_contacts objectAtIndex:indexPath.row] : self.resultsTableController.searchResults[indexPath.row];
    
    DetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    [detailViewController setContact:selectedContact];
    
    [self.navigationController pushViewController:detailViewController animated:YES];

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [context deleteObject:[_contacts objectAtIndex:indexPath.row]];
        NSError *error = nil;
        
        if (![context save:&error]) {
            NSLog(@"%@ %@", error, [error localizedDescription]);
        }
    }
    [self.contacts removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
  
}


#pragma mark - UISearchResultsUpdating

//------------old code
//-(void) updateSearchResultsForSearchController:(UISearchController *)searchController{
//    
//    NSString *searchString = _searchController.searchBar.text;
//    [self updateFilteredContentForAirlineName: searchString];
//    
//    if (self.searchController.searchResultsController) {
//        UINavigationController *navController = (UINavigationController *)self.searchController.searchResultsController;
//        
//        SearchResultsTableViewController *cv = (SearchResultsTableViewController *) navController.topViewController;
//        
//        cv.searchResults = self.searchResults;
//        cv.tableView.delegate = self;
//        [cv.tableView reloadData];
//    }
//    
//}
//------------old code

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    // update the filtered array based on the search text
    NSString *searchText = searchController.searchBar.text;
    [self updateFilteredContentForAirlineName: searchText];
    
    SearchResultsTableViewController *tableController = (SearchResultsTableViewController*) self.searchController.searchResultsController;
    tableController.searchResults = self.searchResults;
    
    [tableController.tableView reloadData];
    
}

-(void) updateFilteredContentForAirlineName:(NSString*)contactName{
    
        if (contactName == nil) {
            _searchResults = [self.contacts mutableCopy];
        }else{
            NSMutableArray *searchingResults = [[NSMutableArray alloc] init];
    
            for (NSManagedObjectModel *thisContact in self.contacts){
    
                if ([[thisContact valueForKey:@"name"] containsString:contactName]) {
    
                    [searchingResults addObject:thisContact];
                }
    
                self.searchResults = searchingResults;
            }
        }
    
}





@end
