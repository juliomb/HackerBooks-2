//
//  TSOLibrary.m
//  HackerBooks
//
//  Created by Timple Soft on 31/3/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

#import "TSOLibrary.h"
#import "TSOBook.h"

@interface TSOLibrary()

@property (nonatomic, strong) NSArray *booksArray;
//@property (nonatomic, strong) NSArray *tagsArray;

@end


@implementation TSOLibrary

# pragma mark - Properties

-(NSUInteger) booksCount{
    return [self.booksArray count];
}

-(id) init{
    
    if (self = [super init]) {
        
        TSOBook *book1 = [[TSOBook alloc] initWithTitle:@"Pro Git"
                                                authors:@[@"Scott Chacon", @"Ben Straub"]
                                                   tags:@[@"version control", @"git"]
                                             urlToImage:[NSURL URLWithString:@"http://hackershelf.com/media/cache/b4/24/b42409de128aa7f1c9abbbfa549914de.jpg"]
                                               urlToPDF:[NSURL URLWithString:@"https://progit2.s3.amazonaws.com/en/2015-03-06-439c2/progit-en.376.pdf"]];
        
        TSOBook *book2 = [[TSOBook alloc] initWithTitle:@"Think Complexity"
                                                authors:@[@"Allen B. Downey"]
                                                   tags:@[@"programming", @"python", @"data structures"]
                                             urlToImage:[NSURL URLWithString:@"http://hackershelf.com/media/cache/97/bf/97bfce708365236e0a5f3f9e26b4a796.jpg"]
                                               urlToPDF:[NSURL URLWithString:@"http://greenteapress.com/compmod/thinkcomplexity.pdf"]];
        
        TSOBook *book3 = [[TSOBook alloc] initWithTitle:@"Think Stats"
                                                authors:@[@"Allen B. Downey"]
                                                   tags:@[@"python", @"programming", @"statistics"]
                                             urlToImage:[NSURL URLWithString:@"http://hackershelf.com/media/cache/46/61/46613d24474140c53ea6b51386f888ff.jpg"]
                                               urlToPDF:[NSURL URLWithString:@"http://greenteapress.com/thinkstats/thinkstats.pdf"]];
        
        _booksArray = @[book1, book2, book3];
        
    }
    
    return self;
    
}


//-(NSArray *) tags{
////    return self;
//}


-(NSUInteger) bookCountForTag:(NSString *) tag{
    
    // Creamos un contador
    NSUInteger counter = 0;
    
    // si el libro contiene el tag sumamos 1
    for (TSOBook *book in self.booksArray){
        if ([book.tags containsObject:tag]) {
            counter += 1;
        }
    }
    
    return counter;
}


-(NSArray *) booksForTag:(NSString *) tag{
    
    // Creamos un array mutable para ir añadiendo los libros
    NSMutableArray *books = [[NSMutableArray alloc] init];
    
    // si el libro contiene el tag lo añadimos
    for (TSOBook *book in self.booksArray){
        if ([book.tags containsObject:tag]) {
            [books addObject:book];
        }
    }
    
    // si no hay ninguno devolvemos nil
    if ([books count] > 0){
        return books;
    }else{
        return nil;
    }
}


-(TSOBook *) bookForTag:(NSString *) tag
                atIndex:(NSUInteger) index{
    
    // Extraemos los libros usando el método anterior
    NSArray *books = [self booksForTag:tag];
    
    // si no existe el tag o el índice es mayor que el número de libros devolvemos nil
    if (books == nil || [books count] <= index){
        return nil;
    }else{
        // devolvemos el libro
        return [books objectAtIndex:index];
    }
    
    
    
}



@end
