//
//  TSOBookViewController.m
//  HackerBooks
//
//  Created by Timple Soft on 2/4/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

#import "TSOBookViewController.h"
#import "TSOBook.h"
#import "Settings.h"
#import "TSOSimplePDFViewController.h"

@interface TSOBookViewController ()

@end

@implementation TSOBookViewController


-(id)initWithModel:(TSOBook *) model{
    if (self = [super initWithNibName:nil bundle:nil]) {
        
        self.title = model.title;
        _model = model;
        
    }
    
    return self;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Asegurarse de que no se ocupa toda la pantalla cuando está en un combinador
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // construimos una string con los elementos de los array
    self.authorsLabel.text = [self.model.authors componentsJoinedByString:@", "];
    self.tagsLabel.text = [self.model.tags componentsJoinedByString:@", "];
    
    // cargamos la imagen dsede la sandbox
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *urls = [fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *url = [urls lastObject];
    url = [url URLByAppendingPathComponent:[IMAGE_PREFIX stringByAppendingString:self.model.title]];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    self.bookImage.image = [UIImage imageWithData:imageData];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)readPDF:(id)sender{
    
    // Creamos el controlador del PDF y hacemos un push
    TSOSimplePDFViewController *pdfVC = [[TSOSimplePDFViewController alloc] initWithModel:self.model];
    [self.navigationController pushViewController:pdfVC animated:YES];
    
}

@end
