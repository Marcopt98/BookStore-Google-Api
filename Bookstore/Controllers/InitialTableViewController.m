//
//  InitialTableViewController.m
//  Bookstore
//
//  Created by itsector on 01/03/2019.
//  Copyright © 2019 itsector. All rights reserved.
//

#import "InitialTableViewController.h"
#import <WebKit/WebKit.h>
#import "CostumTableViewCell.h"
#import "DetailsViewController.h"
#import "Book.h"
#import "UIImageView+AFNetworking.h"
#import "AppDelegate.h"
#import <UIScrollView+SVInfiniteScrolling.h>


@interface InitialTableViewController () <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *SearchTextField;
@property (weak, nonatomic) IBOutlet UIButton *SearchButton;
@property (weak, nonatomic) IBOutlet UITableView *CostumTableView;

@property(weak,nonatomic) AppDelegate *appDelegate;

@property long row;
@property long maxRefresh;

@end

@implementation InitialTableViewController

@synthesize books;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.book = [[Book alloc]init];
    self.books = [[NSMutableArray alloc] init];
    
    
    // setup infinite scrolling
    [self.CostumTableView addInfiniteScrollingWithActionHandler:^{
        [self insertBottomData];
    }];
   
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if(self.appDelegate.lastSearchResult != nil){
        [self startAppFromLastSearch:self.appDelegate.lastSearchResult];
        self.SearchTextField.text = self.appDelegate.lastSearchResult;
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (IBAction)searchOnClick:(UIButton *)sender {
    //[self loadUIWebView];
    NSString *finalResult = @"https://www.googleapis.com/books/v1/volumes?q={theme}";
    NSString *searhResult = self.SearchTextField.text;
    
    if(searhResult.length > 0){
        
        //VERIFICA SE TEM CARACTERES ESPECIAIS
        //NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"?"] invertedSet];
        //if ([searhResult rangeOfCharacterFromSet:set].location != NSNotFound) {
        //    return;
        //}
        
        //VERIFICA SE TEM MAIS QUE UM ESPAÇO
        if ([searhResult componentsSeparatedByString:@" "].count > 2){
            return;
        }
        
        //VERIFICA SE TEM ESPAÇOS PARA SUBSTITUIR
        if ([searhResult componentsSeparatedByString:@" "].count > 0){
            searhResult = [searhResult stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        }
        
        finalResult = [finalResult stringByReplacingOccurrencesOfString:@"{theme}" withString:searhResult];
        
        
        self.appDelegate.resultToSave = searhResult;
        
        self.book.URL = finalResult;
        
        [self makeSearch];
        [self.SearchTextField resignFirstResponder];
        
    }else{
        [self.SearchTextField becomeFirstResponder];
    }
    
}

-(void) startAppFromLastSearch:(NSString *)lastSearch{
    NSString *finalResult = @"https://www.googleapis.com/books/v1/volumes?q={theme}";
    finalResult = [finalResult stringByReplacingOccurrencesOfString:@"{theme}" withString:lastSearch];
    
    self.book.URL = finalResult;
    [self makeSearch];
}


-(void) makeSearch{
    [self.book getBooks:^(NSMutableArray *theBooks) {
        int i=0;
        
        [self.books removeAllObjects];
        
        while (i < theBooks.count) {
            [self.books addObject:theBooks[i]];
            i++;
        }
        self.maxRefresh = self.books.count;
        
        [self.CostumTableView reloadData];
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.books.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CostumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IDCostumCell"];
    Book *thisBook = [[Book alloc]initWithDictionary:self.books[indexPath.row]];
    
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CostumCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    NSURL *url = [NSURL URLWithString:thisBook.Image];

    cell.Title.text = thisBook.Title;
    cell.Date.text = thisBook.Date;
    UIImage *placeholderImage = [UIImage imageNamed:@"avatar"];
    [cell.CostumImageView setImageWithURL:url placeholderImage:placeholderImage];
    
    
    return cell;
}

- (void)insertBottomData {
    
    NSString *link = @"https://www.googleapis.com/books/v1/volumes?q={theme}&startIndex={start}&maxResults={max}";
    
    link = [link stringByReplacingOccurrencesOfString:@"{theme}" withString:self.appDelegate.lastSearchResult];
    NSString* startIndex = [NSString stringWithFormat:@"%i", self.books.count];
    NSString* maxResults = [NSString stringWithFormat:@"%i", 10];
    link = [link stringByReplacingOccurrencesOfString:@"{start}" withString:startIndex];
    link = [link stringByReplacingOccurrencesOfString:@"{max}" withString:maxResults];
    
    
    self.book.URL = link;Cont
    
    if(self.books.count + 10 < self.book.maxItems){
    
        int64_t delayInSeconds = 0.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self.CostumTableView beginUpdates];
            
            
            //self.maxRefresh = self.books.count;
            
            
            
            [self.book getBooks:^(NSMutableArray *theBooks) {
                int i=0;
                
                while (i < theBooks.count) {
                    [self.books addObject:theBooks[i]];
                    [self.CostumTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.books.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
                    i++;
                }
                
                [self.CostumTableView endUpdates];
                
                [self.CostumTableView.infiniteScrollingView stopAnimating];
                
            }];
            
            
        });
        
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.row = indexPath.row;
    [self performSegueWithIdentifier:@"InitialViewToDetailsViewSegue" sender:self];
    [self.CostumTableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"InitialViewToDetailsViewSegue"]){
        
        DetailsViewController *viewController = segue.destinationViewController;
        viewController.linkForDetails = [self.books[self.row] objectForKey:@"selfLink"];
       
        
    }
    
}


@end
