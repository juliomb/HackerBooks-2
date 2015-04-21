//
//  TSODownloadController.m
//  HackerBooks
//
//  Created by Timple Soft on 1/4/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

#import "TSODownloadController.h"
#import "Settings.h"
#import "TSOBook.h"
#import "TSOTag.h"

@implementation TSODownloadController

-(void) downloadAndSaveJSONWithURL:(NSURL *) url
                           context:(NSManagedObjectContext *) context{
    // En este método descargaremos el JSON de la url pasada por parámetro y lo guardaremos
    // en la carpeta Documents de la SandBox
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    if (data != nil) {
        
        // Datos descargados correctamente
        // Sacamos los diccionarios
        NSError *error =nil;
        NSArray *dictArray = [NSJSONSerialization JSONObjectWithData:data
                                                             options:kNilOptions
                                                               error:&error];
        if (dictArray == nil){
            NSLog(@"Error al parsear el JSON: %@", error.userInfo);
        }
        
        if ([dictArray isKindOfClass:[NSArray class]]){
            
            // Guardamos en CoreData
            for (NSDictionary *bookDict in dictArray) {
                
                [TSOBook bookWithDictionary:bookDict
                                    context:context];
                
            }
            
            // Agregamos el Tag Favoritos
            [TSOTag tagWithText:FAVOURITE_TAG book:nil context:context];
            
        }else{
            NSLog(@"No nos hemos descargado un array, si no un diccionario");
        }

    }else{
        NSLog(@"Error descargando los datos");
    }
    
}

/*

-(NSArray *) booksDictionaryArray{
    
    // Leemos el NSData
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *urls = [fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *url = [urls lastObject];
    url = [url URLByAppendingPathComponent:NSDATA_LIBRARY];
    NSError *error =nil;
    NSData *data = [NSData dataWithContentsOfURL:url
                                         options:NSDataReadingMappedIfSafe
                                           error:&error];
    
    // devolvemos un array de diccionarios
    NSArray *dictArray = [NSJSONSerialization JSONObjectWithData:data
                                                         options:kNilOptions
                                                           error:&error];
    if (dictArray == nil){
        NSLog(@"Error al parsear el JSON: %@", error.userInfo);
    }
    
    return dictArray;
    
}

-(NSDictionary *) downloadAndSaveImageWithDictionary:(NSDictionary *) dict{
    // descargamos la imagen
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[dict objectForKey:@"image_url"]]];
    
    // la guardamos en la carpeta documents
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *urls = [fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *url = [urls lastObject];
    url = [url URLByAppendingPathComponent:[IMAGE_PREFIX stringByAppendingString:[dict objectForKey:@"title"]]];
    NSError *error = nil;
    BOOL aux = [imageData writeToURL:url
                           options:NSDataWritingAtomic
                             error:&error];
    // Comprobamos la escritura
    if (!aux){
        NSLog(@"Error al guardar imagen: %@", error.userInfo);
        
    }
    
    // modificamos la url
    NSMutableDictionary *mutable = [NSMutableDictionary dictionaryWithDictionary:dict];
    [mutable setValue:[url lastPathComponent] forKey:@"image_url"];
    return mutable;

}



-(void) savePDFWithBook:(TSOBook *) book
                   data:(NSData *) data{
    
    // lo guardamos en la carpeta documents
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *urls = [fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *url = [urls lastObject];
    url = [url URLByAppendingPathComponent:[PDF_PREFIX stringByAppendingString:book.title]];
    NSError *error = nil;
    BOOL aux = [data writeToURL:url
                        options:NSDataWritingAtomic
                          error:&error];
    // Comprobamos la escritura
    if (!aux){
        NSLog(@"Error al guardar imagen: %@", error.userInfo);
        
    }
}



-(void) updateLibraryWithBook:(TSOBook *) book{
    
    NSMutableArray *libraryArray = [[self booksDictionaryArray] mutableCopy];
    
    NSDictionary *bookDict = [book asJSONDictionary];
    NSString *title = book.title;
    
    NSUInteger index = 0;
    
    for (NSDictionary *bookAux in libraryArray) {
        
        // Si tienen el mismo title reemplazamos los diccionarios
        if ([title compare:[bookAux objectForKey:@"title"]] == 0) {
            [libraryArray setObject:bookDict atIndexedSubscript:index];
            break;
        }
        
        index += 1;
        
    }
    
    // Generamos el NSData con las modificaciones
    NSError *error = nil;
    NSData *newData = [NSJSONSerialization dataWithJSONObject:libraryArray
                                                      options:kNilOptions
                                                        error:&error];
    if (newData == nil) {
        NSLog(@"Error generando el NSData");
    }
    
    // Escribimos en la nueva librería en la sandbox
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *urls = [fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *url = [urls lastObject];
    url = [url URLByAppendingPathComponent:NSDATA_LIBRARY];
    BOOL aux = [newData writeToURL:url
                           options:NSDataWritingAtomic
                             error:&error];
    
    // Comprobamos la escritura
    if (aux){
        NSLog(@"Datos almacenados correctamente");
    }
    
}

*/


@end
