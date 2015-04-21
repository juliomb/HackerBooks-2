//
//  TSOAnnotationsTableViewController.h
//  HackerBooks
//
//  Created by Timple Soft on 21/4/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

@class TSOBook;
#import "AGTCoreDataTableViewController.h"

@interface TSOAnnotationsTableViewController : AGTCoreDataTableViewController

-(id) initWithFetchedResultsController:(NSFetchedResultsController *)aFetchedResultsController
                                 style:(UITableViewStyle)aStyle
                                  book:(TSOBook *)aBook;

@end
