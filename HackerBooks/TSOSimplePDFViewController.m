//
//  TSOSimplePDFViewController.m
//  HackerBooks
//
//  Created by Timple Soft on 2/4/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

#import "TSOSimplePDFViewController.h"
#import "TSOBook.h"
#import "Settings.h"
#import "TSODownloadController.h"
#import "TSOPdf.h"

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
    [self syncWithModel];
    
}


# pragma mark - UIWebViewDelegate
-(void) webViewDidFinishLoad:(UIWebView *)webView{
    
    // paramos el activity
    [self.activityView stopAnimating];
    
    
}


# pragma mark - Utils
-(void) syncWithModel{

    if (self.model.pdf.pdfData) {
        [self.browser loadData:self.model.pdf.pdfData
                      MIMEType:@"application/pdf"
              textEncodingName:@"UTF-8"
                       baseURL:nil];
    }
    else{
        
        [self.activityView setHidden:NO];
        [self.activityView startAnimating];
        
        // CODIGO QUE SE EJECUTA EN OTRO HILO
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            // descargamos y guardamos
            self.model.pdf.pdfData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.pdf.pdfUrl]];
            NSError *error;
            [self.model.managedObjectContext save:&error];
            if (error) {
                NSLog(@"Error al guardar pdf: %@", error.userInfo);
            }
            
            // de vuelta en la cola principal actualizamos el browser
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.activityView stopAnimating];
                
                [self.browser loadData:self.model.pdf.pdfData
                              MIMEType:@"application/pdf"
                      textEncodingName:@"UTF-8"
                               baseURL:nil];
            });

        });
    
    }
    
}


@end
