//
//  AppDelegate.m
//  HackerBooks
//
//  Created by Timple Soft on 31/3/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

#import "AppDelegate.h"
#import "TSOBook.h"
#import "TSOTag.h"
#import "Settings.h"
#import "AGTCoreDataStack.h"
#import "TSOBooksTableViewController.h"
#import "TSODownloadController.h"
#import "LoadingViewController.h"

@interface AppDelegate ()
@property (nonatomic, strong) AGTCoreDataStack *stack;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.stack = [AGTCoreDataStack coreDataStackWithModelName:@"Model"];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    
    /*
    // OJO!!!!
    [userDefaults removeObjectForKey:LAST_SELECTED_BOOK_KEY];
    [self.stack zapAllData];
    [self.stack saveWithErrorBlock:^(NSError *error) {
        NSLog(@"Error al guardar: %@", error);
    }];
    */
    
    
    
    // Si es la primera ejecución, descargamos en JSON y lo guardamos como NSData
    if (![userDefaults objectForKey:LAST_SELECTED_BOOK_KEY]){
        
        // Ponemos el VC de cargando
        LoadingViewController *loadingVC = [[LoadingViewController alloc] init];
        self.window.rootViewController = loadingVC;
        
        // ponemos un valor por defecto
        // TODO: Guardar referencia de coredata
        [userDefaults setObject:@1 forKey:LAST_SELECTED_BOOK_KEY];
        
        // ES LA PRIMERA EJECUCION, descargamos la librería
        // le pasamos la tarea al controlador de descargas
        // y lo hacemos en segundo plano
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSURL *url = [NSURL URLWithString:JSON_URL];
            TSODownloadController *dC = [[TSODownloadController alloc] init];
            [dC downloadAndSaveJSONWithURL:url
                                   context:self.stack.context];
            
            [self.stack saveWithErrorBlock:^(NSError *error) {
                NSLog(@"Error al guardar: %@", error);
            }];
            NSLog(@"Datos guardados en primera ejecución");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // De vuelta en el hilo principal
                [self loadBooksTable];
            
            });
            
        });

        
        // por si acaso
        [userDefaults synchronize];
        
        
    } else{
        
        // Ejecución normal
        [self loadBooksTable];

    }

    // Iniciamos el autoguardar
    [self autoSave];
    
    
    
    /*
    NSIndexPath *ip = [NSIndexPath indexPathForItem:0 inSection:0];
    TSOBook *b = [fc objectAtIndexPath:ip];
    NSLog(@"%@", [b title]);
    */
    
    [self.window makeKeyAndVisible];
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    [self save];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [self save];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



-(void) createTestData{
    
    // Eliminar datos anteriores
    [self.stack zapAllData];
    
    [TSOBook bookWithTitle:@"Primer Libro"
                   authors:@"Yo mismo"
                   context:self.stack.context];
    
    [TSOBook bookWithTitle:@"Segundo Libro"
                   authors:@"Yo mismo"
                   context:self.stack.context];
    
    TSOBook *b3 = [TSOBook bookWithTitle:@"Tercer Libro"
                   authors:@"Yo mismo"
                   context:self.stack.context];
    
    [self.stack saveWithErrorBlock:^(NSError *error) {
        NSLog(@"Error al guardar: %@", error);
    }];
    
    NSLog(@"Libro: %@", b3);
    
    
}



-(void) loadBooksTable{
    /*
    // Cogemos todos los libros
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[TSOBook entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:TSOBookAttributes.title
                                                          ascending:YES
                                                           selector:@selector(caseInsensitiveCompare:)]];
    */
    // Cogemos los tags ordenados
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[TSOTag entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:TSOTagAttributes.text
                                                          ascending:YES
                                                           selector:@selector(caseInsensitiveCompare:)]];
    
    req.fetchBatchSize = 20; // para que te los traiga en bloques de ese tamaño, más o menos el doble de lo que se va a ver
    
    // FetchedResultsController
    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc] initWithFetchRequest:req
                                                                         managedObjectContext:self.stack.context
                                                                           sectionNameKeyPath:TSOTagAttributes.text
                                                                                    cacheName:nil];
    
    TSOBooksTableViewController *booksVC = [[TSOBooksTableViewController alloc] initWithFetchedResultsController:fc
                                                                              style:UITableViewStyleGrouped];
    
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:booksVC];

    self.window.rootViewController = navVC;
    
}



-(void)save{
    
    [self.stack saveWithErrorBlock:^(NSError *error) {
        NSLog(@"Error al guardar %s \n\n %@", __func__, error);
    }];
}

-(void)autoSave{
    
    if (AUTO_SAVE) {
        NSLog(@"Autoguardando....");
        
        [self save];
        [self performSelector:@selector(autoSave)
                   withObject:nil
                   afterDelay:AUTO_SAVE_DELAY_IN_SECONDS];
        
        
    }
}




@end
