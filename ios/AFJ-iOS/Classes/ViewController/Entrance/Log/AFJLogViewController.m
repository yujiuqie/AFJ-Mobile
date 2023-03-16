//
//  AFJLogViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/8/18.
//

#import "AFJLogViewController.h"
#import "AFJLogResultsTableController.h"
#import "AFJLog.h"
#import "AFJLogCell.h"
#import "AFJLogManager.h"

@interface AFJLogViewController ()
        <
        UISearchBarDelegate,
        UISearchControllerDelegate,
        UISearchResultsUpdating
        >


@property(nonatomic, strong) UISearchController *searchController;
@property(nonatomic, assign) NSUInteger taptime;
//@property (nonatomic, strong) NSMutableArray *logs;


// our secondary search results table view
@property(nonatomic, strong) AFJLogResultsTableController *resultsTableController;

// for state restoration
@property BOOL searchControllerWasActive;
@property BOOL searchControllerSearchFieldWasFirstResponder;

@end


#pragma mark -

@implementation AFJLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"日志";

    _resultsTableController = [[AFJLogResultsTableController alloc] init];
    _searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultsTableController];
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.tableView.estimatedRowHeight = 11;

    // we want to be the delegate for our filtered table so didSelectRowAtIndexPath is called for both tables
    self.resultsTableController.tableView.delegate = self;
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO; // default is YES
    self.searchController.searchBar.delegate = self; // so we can monitor text changes + others

    // Search is now just presenting a view controller. As such, normal view controller
    // presentation semantics apply. Namely that presentation will walk up the view controller
    // hierarchy until it finds the root view controller or one that defines a presentation context.
    //
    self.definesPresentationContext = YES;  // know where you want UISearchController to be displayed

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    // restore the searchController's active state
    if (self.searchControllerWasActive) {
        self.searchController.active = self.searchControllerWasActive;
        _searchControllerWasActive = NO;

        if (self.searchControllerSearchFieldWasFirstResponder) {
            [self.searchController.searchBar becomeFirstResponder];
            _searchControllerSearchFieldWasFirstResponder = NO;
        }
    }

    [self.tableView reloadData];
}

#pragma mark -

//- (void)updateLogs:(NSArray<AFJSystemLogMessage *> *)newMessages
//{
//    AFJSystemLogMessage *msg = [newMessages lastObject];
//    
//    if(![msg.messageText hasPrefix:@"[AFJ-iOS-Log]"]){
//        return;
//    }
//    
//    if(!self.logs){
//        self.logs = [NSMutableArray array];
//    }
//    
//    AFJLog *product = [[AFJLog alloc] init];
//    product.title = [NSString stringWithFormat:@"%@ [AFJ-iOS-Log]  %@",msg.date,[msg.messageText substringFromIndex:13]];
//    
//    [self.logs addObject:product];
//    [self.tableView reloadData];
//}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}


#pragma mark - UISearchControllerDelegate

// Called after the search controller's search bar has agreed to begin editing or when
// 'active' is set to YES.
// If you choose not to present the controller yourself or do not implement this method,
// a default presentation is performed on your behalf.
//
// Implement this method if the default presentation is not adequate for your purposes.
//
- (void)presentSearchController:(UISearchController *)searchController {

}

- (void)willPresentSearchController:(UISearchController *)searchController {
    // do something before the search controller is presented
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    // do something after the search controller is presented
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    // do something before the search controller is dismissed
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    // do something after the search controller is dismissed
}


#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[AFJLogManager sharedInstance] logs] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AFJLogCell *cell = (AFJLogCell *) [self.tableView dequeueReusableCellWithIdentifier:kAFJLogCellIdentifier forIndexPath:indexPath];

    AFJLog *product = [[AFJLogManager sharedInstance] logs][indexPath.row];
    [self configureCell:cell forProduct:product];

    return cell;
}

// here we are the table view delegate for both our main table and filtered table, so we can
// push from the current navigation controller (resultsTableController's parent view controller
// is not this UINavigationController)
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    AFJLog *selectedProduct = (tableView == self.tableView) ?
            [[AFJLogManager sharedInstance] logs][indexPath.row] : self.resultsTableController.filteredLogs[indexPath.row];

    NSUInteger curr = [[NSDate date] timeIntervalSince1970];

    if (curr - self.taptime < 1) {
        UIPasteboard *board = [UIPasteboard generalPasteboard];
        board.string = selectedProduct.title;

        [self.view makeToast:@"已复制到粘贴板"
                    duration:2
                    position:CSToastPositionCenter];
    }

    self.taptime = curr;

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    // update the filtered array based on the search text
    NSString *searchText = searchController.searchBar.text;
    NSMutableArray *searchResults = [[[AFJLogManager sharedInstance] logs] mutableCopy];

    // strip out all the leading and trailing spaces
    NSString *strippedString = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    // break up the search terms (separated by spaces)
    NSArray *searchItems = nil;
    if (strippedString.length > 0) {
        searchItems = [strippedString componentsSeparatedByString:@" "];
    }

    // build all the "AND" expressions for each value in the searchString
    //
    NSMutableArray *andMatchPredicates = [NSMutableArray array];

    for (NSString *searchString in searchItems) {
        // each searchString creates an OR predicate for: name, yearIntroduced, introPrice
        //
        // example if searchItems contains "iphone 599 2007":
        //      name CONTAINS[c] "iphone"
        //      name CONTAINS[c] "599", yearIntroduced ==[c] 599, introPrice ==[c] 599
        //      name CONTAINS[c] "2007", yearIntroduced ==[c] 2007, introPrice ==[c] 2007
        //
        NSMutableArray *searchItemsPredicate = [NSMutableArray array];

        // Below we use NSExpression represent expressions in our predicates.
        // NSPredicate is made up of smaller, atomic parts: two NSExpressions (a left-hand value and a right-hand value)

        // name field matching
        NSExpression *lhs = [NSExpression expressionForKeyPath:@"title"];
        NSExpression *rhs = [NSExpression expressionForConstantValue:searchString];
        NSPredicate *finalPredicate = [NSComparisonPredicate
                predicateWithLeftExpression:lhs
                            rightExpression:rhs
                                   modifier:NSDirectPredicateModifier
                                       type:NSContainsPredicateOperatorType
                                    options:NSCaseInsensitivePredicateOption];
        [searchItemsPredicate addObject:finalPredicate];

        // at this OR predicate to our master AND predicate
        NSCompoundPredicate *orMatchPredicates = [NSCompoundPredicate orPredicateWithSubpredicates:searchItemsPredicate];
        [andMatchPredicates addObject:orMatchPredicates];
    }

    // match up the fields of the Product object
    NSCompoundPredicate *finalCompoundPredicate =
            [NSCompoundPredicate andPredicateWithSubpredicates:andMatchPredicates];
    searchResults = [[searchResults filteredArrayUsingPredicate:finalCompoundPredicate] mutableCopy];

    // hand over the filtered results to our search results table
    AFJLogResultsTableController *tableController = (AFJLogResultsTableController *) self.searchController.searchResultsController;
    tableController.filteredLogs = searchResults;
    [tableController.tableView reloadData];
}


#pragma mark - UIStateRestoration

// we restore several items for state restoration:
//  1) Search controller's active state,
//  2) search text,
//  3) first responder

NSString *const AFJLogViewControllerTitleKey = @"AFJLogViewControllerTitleKey";
NSString *const AFJLogSearchControllerIsActiveKey = @"AFJLogSearchControllerIsActiveKey";
NSString *const AFJLogSearchBarTextKey = @"AFJLogSearchBarTextKey";
NSString *const AFJLogSearchBarIsFirstResponderKey = @"AFJLogSearchBarIsFirstResponderKey";

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];

    // encode the view state so it can be restored later

    // encode the title
    [coder encodeObject:self.title forKey:AFJLogViewControllerTitleKey];

    UISearchController *searchController = self.searchController;

    // encode the search controller's active state
    BOOL searchDisplayControllerIsActive = searchController.isActive;
    [coder encodeBool:searchDisplayControllerIsActive forKey:AFJLogSearchControllerIsActiveKey];

    // encode the first responser status
    if (searchDisplayControllerIsActive) {
        [coder encodeBool:[searchController.searchBar isFirstResponder] forKey:AFJLogSearchBarIsFirstResponderKey];
    }

    // encode the search bar text
    [coder encodeObject:searchController.searchBar.text forKey:AFJLogSearchBarTextKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];

    // restore the title
    self.title = [coder decodeObjectForKey:AFJLogViewControllerTitleKey];

    // restore the active state:
    // we can't make the searchController active here since it's not part of the view
    // hierarchy yet, instead we do it in viewWillAppear
    //
    _searchControllerWasActive = [coder decodeBoolForKey:AFJLogSearchControllerIsActiveKey];

    // restore the first responder status:
    // we can't make the searchController first responder here since it's not part of the view
    // hierarchy yet, instead we do it in viewWillAppear
    //
    _searchControllerSearchFieldWasFirstResponder = [coder decodeBoolForKey:AFJLogSearchBarIsFirstResponderKey];
    // restore the text in the search field
    self.searchController.searchBar.text = [coder decodeObjectForKey:AFJLogSearchBarTextKey];
}

@end
