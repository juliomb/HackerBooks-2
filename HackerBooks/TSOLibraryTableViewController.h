//
//  TSOLibraryTableViewController.h
//  HackerBooks
//
//  Created by Timple Soft on 3/4/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

@import UIKit;
@class TSOLibrary;

@interface TSOLibraryTableViewController : UITableViewController

@property (nonatomic, strong) TSOLibrary *model;

-(id) initWithModel:(TSOLibrary *) model
              style:(UITableViewStyle) style;

@end
