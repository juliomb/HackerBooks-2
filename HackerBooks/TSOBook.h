//
//  TSOBook.h
//  HackerBooks
//
//  Created by Timple Soft on 31/3/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSOBook : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *authors;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) NSURL *urlToImage;
@property (nonatomic, strong) NSURL *urlToPDF;
@property (nonatomic, readwrite) BOOL isFavourite;

// Inicializadores designados
-(id) initWithTitle:(NSString *) title
            authors:(NSArray *) authors
               tags:(NSArray *) tags
         urlToImage:(NSURL *) urlToImage
           urlToPDF:(NSURL *) urlToPDF;

-(id) initWithDictionary:(NSDictionary *) dictionary;

-(void) downloadedPDFWithData:(NSData *) data;
-(void) addToFavourites;
-(void) removeFromFavourites;

-(NSData *) imageData;
-(NSData *) pdfData;
-(NSDictionary *) asJSONDictionary;


@end
