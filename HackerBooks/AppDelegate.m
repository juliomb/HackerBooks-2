//
//  AppDelegate.m
//  HackerBooks
//
//  Created by Timple Soft on 31/3/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

#import "AppDelegate.h"
#import "TSOBook.h"
#import "Settings.h"
#import "AGTCoreDataStack.h"
#import "TSOBooksTableViewController.h"

@interface AppDelegate ()
@property (nonatomic, strong) AGTCoreDataStack *stack;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /*
    // Si es la primera ejecución, descargamos en JSON y lo guardamos como NSData
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    TSODownloadController *dC = [[TSODownloadController alloc] init];
    
    //[userDefaults removeObjectForKey:LAST_SELECTED_BOOK]; // OJO!!!!
    if (![userDefaults objectForKey:LAST_SELECTED_BOOK]){
        
        // ponemos un valor por defecto
        [userDefaults setObject:@[@0, @0] forKey:LAST_SELECTED_BOOK];
        
        // ES LA PRIMERA EJECUCION, descargamos la librería
        // le pasamos la tarea al controlador de descargas
        NSURL *url = [NSURL URLWithString:JSON_URL];
        [dC downloadAndSaveJSONWithURL:url];
        
        // por si acaso
        [userDefaults synchronize];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    // Cogemos los datos de local e inicializamos la librería
    NSArray *dictArray = [dC booksDictionaryArray];
    TSOLibrary *library = [[TSOLibrary alloc] initWithArray:dictArray];

    
    // Detectamos el tipo de pantalla
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        // Tipo tableta
        [self configureForPadWithModel:library];
        
    }else{
        
        // Tipo teléfono
        [self configureForPhoneWithModel:library];
        
    }
    */
    
    self.stack = [AGTCoreDataStack coreDataStackWithModelName:@"Model"];
    
    // Creamos datos de prueba
    //[self createTestData];
    
    // Cogemos todos los libros
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[TSOBook entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:TSOBookAttributes.title
                                                          ascending:YES
                                                           selector:@selector(caseInsensitiveCompare:)]];
    req.fetchBatchSize = 20; // para que te los traiga en bloques de ese tamaño, más o menos el doble de lo que se va a ver
    
    // FetchedResultsController
    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc] initWithFetchRequest:req
                                                                         managedObjectContext:self.stack.context
                                                                           sectionNameKeyPath:nil // para ordendar más adelante por tags
                                                                                    cacheName:nil];
    
    TSOBooksTableViewController *booksVC = [[TSOBooksTableViewController alloc] initWithFetchedResultsController:fc
                                                                                                           style:UITableViewStyleGrouped];
    
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:booksVC];
    
    self.window.rootViewController = booksVC;
    
    
    [self.window makeKeyAndVisible];
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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

/*
-(TSOBook *) lastSelectedBookInModel:(TSOLibrary *) model{
    
    // Obtengo en NSUserDefaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    // Saco las coordenadas del último personaje
    NSArray *coords = [userDefaults objectForKey:LAST_SELECTED_BOOK];
    NSUInteger section = [[coords firstObject] integerValue];
    NSUInteger position = [[coords lastObject] integerValue];
    
    // Obtengo el libro
    NSString *tag = [[model tags] objectAtIndex:section];
    TSOBook *book = [model bookForTag:tag atIndex:position];
    
    // Lo devuelvo
    return book;
    
}


-(void) configureForPadWithModel:(TSOLibrary *) library{
    
    // Creamos los controladores
    TSOLibraryTableViewController *libVC = [[TSOLibraryTableViewController alloc] initWithModel:library
                                                                                          style:UITableViewStyleGrouped];
    TSOBookViewController *bookVC = [[TSOBookViewController alloc] initWithModel:[self lastSelectedBookInModel:library]];
    
    // Creamos los navigation
    UINavigationController *libNav = [[UINavigationController alloc] initWithRootViewController:libVC];
    UINavigationController *bookNav = [[UINavigationController alloc] initWithRootViewController:bookVC];
    
    
    // Creamos el combinador
    UISplitViewController *splitVC = [[UISplitViewController alloc] init];
    splitVC.viewControllers = @[libNav, bookNav];
    
    // Asignamos los delegados
    splitVC.delegate = bookVC;
    libVC.delegate = bookVC;
    
    // lo hacemos root
    self.window.rootViewController = splitVC;
}



-(void) configureForPhoneWithModel:(TSOLibrary *) library{

    // Creamos el controlador
    TSOLibraryTableViewController *libVC = [[TSOLibraryTableViewController alloc] initWithModel:library
                                                                                          style:UITableViewStyleGrouped];
    // Creamos el navigation
    UINavigationController *libNav = [[UINavigationController alloc] initWithRootViewController:libVC];
    
    // Asignamos los delegados
    libVC.delegate = libVC;
    
    // Lo hacemos root
    self.window.rootViewController = libNav;

}
 */


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










@end
