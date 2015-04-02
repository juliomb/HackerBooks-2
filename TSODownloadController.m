//
//  TSODownloadController.m
//  HackerBooks
//
//  Created by Timple Soft on 1/4/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

#import "TSODownloadController.h"
#import "Settings.h"

@implementation TSODownloadController

-(void) downloadAndSaveJSONWithURL:(NSURL *) url{
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
        
        // Descargamos, guardamos las imágenes y actualizamos el diccionario
        NSMutableArray *arrayWithLocalImages = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in dictArray){
            NSDictionary *dictWithImage = [self downloadAndSaveImageWithDictionary:dict];
            [arrayWithLocalImages addObject:dictWithImage];
        }
            
        // Ordenamos los libros alfabéticamente
        NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
        NSArray *descriptors = [NSArray arrayWithObject:descriptor];
        NSArray *sortedArray = [arrayWithLocalImages sortedArrayUsingDescriptors:descriptors];
        
        // Generamos el NSData con las modificaciones
        NSData *newData = [NSJSONSerialization dataWithJSONObject:sortedArray
                                                          options:kNilOptions
                                                            error:&error];
        if (newData == nil) {
            NSLog(@"Error generando el NSData");
        }
            
        // Escribimos en la sandbox
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
            
        }else{
            NSLog(@"Error al escribir los datos: %@", error.userInfo);
        }

    }else{
        NSLog(@"Error descargando los datos");
    }
    
}


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

@end
