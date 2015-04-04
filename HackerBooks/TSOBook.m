//
//  TSOBook.m
//  HackerBooks
//
//  Created by Timple Soft on 31/3/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

#import "TSOBook.h"
#import "Settings.h"
#import "TSODownloadController.h"

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
        
        if ([tags containsObject:FAVOURITE_TAG]){
            _isFavourite = YES;
        }else{
            _isFavourite = NO;
        }
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


-(void) downloadedPDFWithData:(NSData *) data{
    
    // si teníamos la url no vacía significa que tenemos que guardar en local
    if ([[self.urlToPDF absoluteString] compare:@""] != 0){
        
        // ponemos la url vacía
        self.urlToPDF = [NSURL URLWithString:@""];
        
        // Guardamos el pdf
        TSODownloadController *dc = [[TSODownloadController alloc] init];
        [dc savePDFWithBook:self data:data];
        
        // Actualizamos el JSON de la librería
        [dc updateLibraryWithBook:self];
        
        // Mandamos notificacion de PDF descargado
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        NSNotification *notification = [NSNotification notificationWithName:BOOK_DID_DOWNLOAD_PDF
                                                                     object:self
                                                                   userInfo:nil];
        [nc postNotification:notification];
    }

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
    
    NSMutableString *url = [@"" mutableCopy];
    // si no tenemos guardado el libro en local guardamos la url de internet
    if ([[self.urlToPDF absoluteString] compare:@""] != 0){
        url = [[self.urlToPDF absoluteString] mutableCopy];
    }
    
    return @{@"authors": [self.authors componentsJoinedByString:@", "],
             @"image_url": @"",
             @"pdf_url": url,
             @"tags": [self.tags componentsJoinedByString:@", "],
             @"title": self.title};
    
}


-(void) addToFavourites{
    
    // Añadimos el tag favoritos
    NSMutableArray *mutableTags = [self.tags mutableCopy];
    [mutableTags addObject:FAVOURITE_TAG];
    self.tags = mutableTags;
    
    // Ponemos a true la propiedad booleana
    self.isFavourite = YES;
    
    // Mandamos notificación
    [self postFavouritesChangeNotification];
    
    // Persistimos los cambios
    TSODownloadController *dc = [[TSODownloadController alloc] init];
    [dc updateLibraryWithBook:self];
    
}

-(void) removeFromFavourites{
    
    // Eliminamos el tag favoritos
    NSMutableArray *mutableTags = [self.tags mutableCopy];
    [mutableTags removeObject:FAVOURITE_TAG];
    self.tags = mutableTags;
    
    // Ponemos a false la propiedad booleana
    self.isFavourite = NO;
    
    // Mandamos notificación
    [self postFavouritesChangeNotification];
    
    // Persistimos los cambios
    TSODownloadController *dc = [[TSODownloadController alloc] init];
    [dc updateLibraryWithBook:self];
    
}



-(void) postFavouritesChangeNotification{
    // Mandamos notificacion que ha cambiado la seccion favoritos
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    NSNotification *notification = [NSNotification notificationWithName:FAVOURITES_DID_CHANGE
                                                                 object:self
                                                               userInfo:nil];
    [nc postNotification:notification];
}

@end
