//
//  TSOSimplePDFViewController.h
//  HackerBooks
//
//  Created by Timple Soft on 2/4/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

@import UIKit;
@class TSOBook;

@interface TSOSimplePDFViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) TSOBook *model;

@property (weak, nonatomic) IBOutlet UIWebView *browser;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

-(id) initWithModel:(TSOBook *) model;

@end
