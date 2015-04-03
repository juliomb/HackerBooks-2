//
//  TSOBookViewController.h
//  HackerBooks
//
//  Created by Timple Soft on 2/4/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

@import UIKit;
@class TSOBook;
#import "TSOLibraryTableViewController.h"

@interface TSOBookViewController : UIViewController <UISplitViewControllerDelegate, TSOLibraryTableViewControllerDelegate>

@property (strong, nonatomic) TSOBook *model;

@property (weak, nonatomic) IBOutlet UILabel *authorsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bookImage;
@property (weak, nonatomic) IBOutlet UILabel *tagsLabel;

- (IBAction)readPDF:(id)sender;

-(id)initWithModel:(TSOBook *) model;


@end
