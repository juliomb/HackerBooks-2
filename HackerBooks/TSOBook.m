//
//  TSOBook.m
//  HackerBooks
//
//  Created by Timple Soft on 31/3/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

#import "TSOBook.h"
#import "Settings.h"

@implementation TSOBook


-(id) initWithTitle:(NSString *) title
            authors:(NSArray *) authors
               tags:(NSArray *) tags
         urlToImage:(NSURL *) urlToImage
           urlToPDF:(NSURL *) urlToPDF{
    
    if (self = [super init]){
        _title = title;
        _authors = authors;
        _tags = tags;
        _urlToImage = urlToImage;
        _urlToPDF = urlToPDF;
    }
    
    return self;
    
}


-(id) initWithDictionary:(NSDictionary *) dictionary{
    
    NSURL *imageURL = [NSURL URLWithString:[dictionary objectForKey:@"image_url"]];
    NSURL *pdfURL = [NSURL URLWithString:[dictionary objectForKey:@"pdf_url"]];
    
    // Convertimos los tags y los autores en arrays
    NSString *authorsString = [dictionary objectForKey:@"authors"];
    NSArray *authorsArray = [authorsString componentsSeparatedByString:@", "];
    NSString *tagsString = [dictionary objectForKey:@"tags"];
    NSArray *tagsArray = [tagsString componentsSeparatedByString:@", "];
    
    return [self initWithTitle:[dictionary objectForKey:@"title"]
                       authors:authorsArray
                          tags:tagsArray
                    urlToImage:imageURL
                      urlToPDF:pdfURL];
}


-(NSString *) description{
    
    return [NSString stringWithFormat:@"<%@: %@>",
            [self class], [self title]];
    
}


// Sobreescribimos el setter de urlToPDF para enviar notificacion
-(void) downloadedPDF{
    
    self.urlToPDF = [NSURL URLWithString:@""];
    
    // Mandamos notificacion si la url es vacía, PDF descargado
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    NSNotification *notification = [NSNotification notificationWithName:BOOK_DID_DOWNLOAD_PDF
                                                                 object:self
                                                               userInfo:nil];
    [nc postNotification:notification];

}


-(NSData *) imageData{
    
    // Método que recoge de la sandbox la imagen del libro y la devuelve en un NSData
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *urls = [fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *url = [urls lastObject];
    url = [url URLByAppendingPathComponent:[IMAGE_PREFIX stringByAppendingString:self.title]];
    return [NSData dataWithContentsOfURL:url];
    
}


-(NSData *) pdfData{
    
    // Si tenemos el pdf en local lo rescata de la sandbox y lo pasa, si no lo descarga
    if ([[self.urlToPDF absoluteString] compare:@""] == 0){
        NSFileManager *fm = [NSFileManager defaultManager];
        NSArray *urls = [fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
        NSURL *url = [urls lastObject];
        url = [url URLByAppendingPathComponent:[PDF_PREFIX stringByAppendingString:self.title]];
        return [NSData dataWithContentsOfURL:url];
    }else{
        return [NSData dataWithContentsOfURL:self.urlToPDF];
    }
    
}

-(NSDictionary *) asJSONDictionary{
    
    return @{@"authors": [self.authors componentsJoinedByString:@", "],
             @"image_url": @"",
             @"pdf_url": @"",
             @"tags": [self.tags componentsJoinedByString:@", "],
             @"title": self.title};
    
}

@end
