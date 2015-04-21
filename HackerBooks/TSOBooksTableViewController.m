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
#import "TSOPdf.h"
#import "TSOPhoto.h"
#import "Settings.h"
#import "TSOTag.h"
#import "TSOBookViewController.h"


@interface TSOBooksTableViewController ()

@end

@implementation TSOBooksTableViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.sortedArray = [self.fetchedResultsController.fetchedObjects sortedArrayUsingSelector:@selector(compare:)];
    
    [self.tableView reloadData];
}


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
    TSOBook *book = [self bookAtIndexPath:indexPath];
    
    // Cramos la celda
    TSOBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TSOBookTableViewCell cellId]
                                                                 forIndexPath:indexPath];
    
    // Configuramos la celda
    cell.titleLabel.text = book.title;
    cell.authorsLabel.text = book.authors;
    
    // Si tenemos imagen la mostramos, si no en pequeño
    if (book.photo.photoData) {
        cell.bookIcon.image = [UIImage imageWithData:book.photo.photoData];
    }else{
        cell.bookIcon.image = [UIImage imageNamed:@"default-book-large.gif"];
    }
    
    
    // si tenemos el pdf en local le quitamos la transparencia al icono
    if (book.pdf.pdfData){
        cell.downloadIcon.alpha = 1;
    }else{
        cell.downloadIcon.alpha = 0.3f;
    }
    
    
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BOOK_CELL_HEIGHT;
}



-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    TSOTag *tag = [self.sortedArray objectAtIndex:section];
    return tag.text;
    
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    TSOTag *tag = [self.sortedArray objectAtIndex:section];
    return tag.books.count;
    
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Rescatamos el libro
    TSOBook *book = [self bookAtIndexPath:indexPath];
    
    TSOBookViewController *bookVC = [[TSOBookViewController alloc] initWithModel:book];
    
    [self.navigationController pushViewController:bookVC animated:YES];
    
}



#pragma mark - Utils

-(TSOBook *) bookAtIndexPath:(NSIndexPath *) indexPath{
    // NADA EFICIENTE, PERO NO ME FUNCIONA NADA MAS
    TSOTag *tag = [self.sortedArray objectAtIndex:indexPath.section];
    
    // Rescatamos el libro
    NSArray *books = [tag.books allObjects];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    NSArray *sortedBooks = [books sortedArrayUsingDescriptors:@[sortDescriptor]];
    return [sortedBooks objectAtIndex:indexPath.row];
}



@end
