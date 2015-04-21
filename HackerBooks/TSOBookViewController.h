//
//  TSOBookViewController.h
//  HackerBooks
//
//  Created by Timple Soft on 2/4/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

@import UIKit;
@class TSOBook;
#import "TSOBooksTableViewController.h"

@interface TSOBookViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) TSOBook *model;

@property (weak, nonatomic) IBOutlet UILabel *authorsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bookImage;
@property (weak, nonatomic) IBOutlet UILabel *tagsLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *favouriteButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;

- (IBAction)readPDF:(id)sender;
- (IBAction)setFavorite:(id)sender;

-(id)initWithModel:(TSOBook *) model;


@end
