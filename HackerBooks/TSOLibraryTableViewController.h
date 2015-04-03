//
//  TSOLibraryTableViewController.h
//  HackerBooks
//
//  Created by Timple Soft on 3/4/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

@import UIKit;
#import "TSOLibrary.h"

@class TSOLibraryTableViewController;

@protocol TSOLibraryTableViewControllerDelegate <NSObject>

@optional
-(void) libraryTableViewController:(TSOLibraryTableViewController *) libVC
                     didSelectBook:(TSOBook *) book;
@end


@interface TSOLibraryTableViewController : UITableViewController

@property (nonatomic, strong) TSOLibrary *model;
@property (nonatomic, weak) id<TSOLibraryTableViewControllerDelegate> delegate;


-(id) initWithModel:(TSOLibrary *) model
              style:(UITableViewStyle) style;

@end
