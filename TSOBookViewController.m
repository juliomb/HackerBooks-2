//
//  TSOBookViewController.m
//  HackerBooks
//
//  Created by Timple Soft on 2/4/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

#import "TSOBookViewController.h"
#import "TSOBook.h"
#import "Settings.h"
#import "TSOSimplePDFViewController.h"

@interface TSOBookViewController ()

@end

@implementation TSOBookViewController


-(id)initWithModel:(TSOBook *) model{
    if (self = [super initWithNibName:nil bundle:nil]) {
        
        self.title = model.title;
        _model = model;
        
    }
    
    return self;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Asegurarse de que no se ocupa toda la pantalla cuando está en un combinador
    self.edgesForExtendedLayout = UIRectEdgeNone;

    // Sincronizamos vista y modelo
    [self syncViewWithModel];
    
    // Si estoy dentro de un SplitVC me pongo el botón
    self.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    
    // Alta en notificaciones para cambiar imagen de favoritos
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(favouritesDidChange:)
               name:FAVOURITES_DID_CHANGE
             object:nil];
    
}

-(void) viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    // baja en notifaciones
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)readPDF:(id)sender{
    
    // Creamos el controlador del PDF y hacemos un push
    TSOSimplePDFViewController *pdfVC = [[TSOSimplePDFViewController alloc] initWithModel:self.model];
    [self.navigationController pushViewController:pdfVC animated:YES];
    
}

- (IBAction)setFavorite:(id)sender {
    
    if ([self.model isFavourite]) {
        // lo quitamos
        [self.model removeFromFavourites];
    }else{
        // lo ponemos
        [self.model addToFavourites];
    }
    
    self.tagsLabel.text = [self.model.tags componentsJoinedByString:@", "];
    
}


// FAVOURITES_DID_CHANGE
-(void) favouritesDidChange:(NSNotification *) notification{
    
    if ([self.model isFavourite]) {
        self.favouriteButton.image = [UIImage imageNamed:@"favorito.png"];
    }else{
        self.favouriteButton.image = [UIImage imageNamed:@"noFavorito.png"];
    }
    
}


# pragma mark - Utils
-(void) syncViewWithModel{
    
    self.title = self.model.title;
    
    // construimos una string con los elementos de los array
    self.authorsLabel.text = [self.model.authors componentsJoinedByString:@", "];
    self.tagsLabel.text = [self.model.tags componentsJoinedByString:@", "];
    
    // cargamos la imagen dsede la sandbox
    self.bookImage.image = [UIImage imageWithData:[self.model imageData]];
    
    // Cambiamos el icono dependiendo si es favorito o no
    if ([self.model isFavourite]){
        self.favouriteButton.image = [UIImage imageNamed:@"favorito.png"];
    }else{
        self.favouriteButton.image = [UIImage imageNamed:@"noFavorito.png"];
    }
    
}

# pragma mark - UISplitViewControllerDelegate
-(void) splitViewController:(UISplitViewController *)svc
    willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode{
    
    // Averiguar si la tabla se ve o no
    if (displayMode == UISplitViewControllerDisplayModePrimaryHidden) {
        
        // La tabla está oculta y cuelga del botón
        // Ponemos ese botón en mi barra de navegación
        self.navigationItem.leftBarButtonItem = svc.displayModeButtonItem;
        
    }else{
        
        // Se muestra la tabla: oculto el botón de la barra de navegación
        self.navigationItem.leftBarButtonItem = nil;
        
    }
    
    
}


# pragma mark - TSOLibraryTableViewControllerDelegate
-(void) libraryTableViewController:(TSOLibraryTableViewController *)libVC didSelectBook:(TSOBook *)book{
    
    // cambiamos el modelo
    self.model = book;
    
    // sincronizamos modelo y vista
    [self syncViewWithModel];
    
}

@end
