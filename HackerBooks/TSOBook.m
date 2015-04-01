//
//  TSOBook.m
//  HackerBooks
//
//  Created by Timple Soft on 31/3/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

#import "TSOBook.h"

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


-(NSString *) description{
    
    return [NSString stringWithFormat:@"<%@: %@>",
            [self class], [self title]];
    
}


@end
