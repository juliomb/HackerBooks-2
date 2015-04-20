//
//  TSOBooksTableViewController.m
//  HackerBooks
//
//  Created by Timple Soft on 13/4/15.
//  Copyright (c) 2015 TimpleSoft. All rights reserved.
//

#import "TSOBooksTableViewController.h"
#import "TSOBookTableViewCell.h"
#import "TSOBook.h"
#import "Settings.h"

@interface TSOBooksTableViewController ()

@end

@implementation TSOBooksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Librería";
    
    
    // Registramos el nib de la celda personalizada
    UINib *nib = [UINib nibWithNibName:@"TSOBookTableViewCell"
                                bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib
         forCellReuseIdentifier:[TSOBookTableViewCell cellId]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Rescatamos el libro
    TSOBook *book = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Cramos la celda
    TSOBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TSOBookTableViewCell cellId]
                                                                 forIndexPath:indexPath];
    
    // Configuramos la celda
    cell.titleLabel.text = book.title;
    cell.authorsLabel.text = book.authors;
    //cell.bookIcon.image = [UIImage imageWithData:[book imageData]]; TODO
    
    // si tenemos el pdf en local le quitamos la transparencia al icono
    if (book.pdf){
        cell.downloadIcon.alpha = 1;
    }else{
        cell.downloadIcon.alpha = 0.3f;
    }
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BOOK_CELL_HEIGHT;
}




@end
