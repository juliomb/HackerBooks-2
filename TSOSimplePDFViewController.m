//
//  TSOSimplePDFViewController.m
//  HackerBooks
//
//  Created by Timple Soft on 2/4/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

#import "TSOSimplePDFViewController.h"
#import "TSOBook.h"

@interface TSOSimplePDFViewController ()

@end

@implementation TSOSimplePDFViewController


-(id) initWithModel:(TSOBook *) model{
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = model;
        self.title = model.title;
    }
    
    return self;
}


-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // Asegurarse de que no se ocupa toda la pantalla cuando está en un combinador
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.browser.delegate = self;
    
    // arrancamos le inidicator y empezamos a cargar el pdf
    [self.activityView setHidden:NO];
    [self.activityView startAnimating];
    [self.browser loadRequest:[NSURLRequest requestWithURL:self.model.urlToPDF]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


# pragma mark - UIWebViewDelegate
-(void) webViewDidFinishLoad:(UIWebView *)webView{
    
    // paramos el activity
    [self.activityView stopAnimating];
    
}



@end
