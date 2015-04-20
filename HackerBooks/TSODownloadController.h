//
//  TSODownloadController.h
//  HackerBooks
//
//  Created by Timple Soft on 1/4/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

@import Foundation;
@import CoreData;
@class TSOBook;


@interface TSODownloadController : NSObject

-(void) downloadAndSaveJSONWithURL: (NSURL *) url
                           context: (NSManagedObjectContext *) context;

/*
-(NSArray *) booksDictionaryArray;
-(void) savePDFWithBook:(TSOBook *) book
                   data:(NSData *) data;
-(void) updateLibraryWithBook:(TSOBook *) book;
*/

    
@end
