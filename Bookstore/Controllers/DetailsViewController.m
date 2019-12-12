//
//  DetailsViewController.m
//  Bookstore
//
//  Created by itsector on 01/03/2019.
//  Copyright © 2019 itsector. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import <WebKit/WebKit.h>
#import <SafariServices/SafariServices.h>

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *ImageViewDetails;
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *AuthorsLabel;
@property (weak, nonatomic) IBOutlet UITextView *SinopseLabel;
@property (weak, nonatomic) IBOutlet UILabel *CategoriesLabel;
@property (weak, nonatomic) IBOutlet UILabel *PagesLabel;
@property (weak, nonatomic) IBOutlet UIButton *PreviewButtonOutlet;


@property (strong, nonatomic) WKWebViewConfiguration *theConfiguration;
@property (strong, nonatomic) WKWebView *webView;

@end

@implementation DetailsViewController

@synthesize bookDetails, linkForDetails;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.bookDetails = [[BookDetails alloc]init];
    self.bookDetails.selfLink = self.linkForDetails;
    
    [self.bookDetails getSingleBook:^(BookDetails* theBook) {
        //RECEBE UM DICIONARIO
        id bookDictionary = theBook;
    
        self.bookDetails = [[BookDetails alloc]initWithDictionary:bookDictionary];
        
        // APAGAR OS <P>, <i> e <br> DO TEXTO
        
        self.bookDetails.Sinopse = [self.bookDetails.Sinopse stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
        self.bookDetails.Sinopse = [self.bookDetails.Sinopse stringByReplacingOccurrencesOfString:@"</p> " withString:@"\n"];
        self.bookDetails.Sinopse = [self.bookDetails.Sinopse stringByReplacingOccurrencesOfString:@"<i>" withString:@""];
        self.bookDetails.Sinopse = [self.bookDetails.Sinopse stringByReplacingOccurrencesOfString:@"</i> " withString:@""];
        self.bookDetails.Sinopse = [self.bookDetails.Sinopse stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
        
        
        [self presentItem];
        
        
        if(self.bookDetails.Preview == nil){
            self.PreviewButtonOutlet.enabled = NO;
        }
    }];
}


#pragma mark - Navigation

- (void)presentItem {
    self.TitleLabel.text = self.bookDetails.Title;
   
    NSURL *url = [NSURL URLWithString:self.bookDetails.Image];
    UIImage *placeholderImage = [UIImage imageNamed:@"avatar"];
    [self.ImageViewDetails setImageWithURL:url placeholderImage:placeholderImage];
    
    self.AuthorsLabel.text = self.bookDetails.Author;
    self.CategoriesLabel.text = self.bookDetails.Categories;
    NSString *pages = [NSString stringWithFormat: @"%i Pages ",self.bookDetails.pageCount];
    self.PagesLabel.text = pages;
    self.SinopseLabel.text = self.bookDetails.Sinopse;
}

- (IBAction)previewOnClick:(UIButton *)sender {
    /*
     self.theConfiguration = [[WKWebViewConfiguration alloc] init];
     self.webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:self.theConfiguration];
     self.webView.navigationDelegate = self;
    
    //URL
    
     NSURL *nsurl=[NSURL URLWithString:self.bookDetails.Preview];
     NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
     [self.webView loadRequest:nsrequest];
     [self.view addSubview:self.webView];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back_selector:)];
    
    
    self.navigationItem.leftBarButtonItem = backButton;
    */
    
    NSURL *nsurl=[NSURL URLWithString:self.bookDetails.Preview];
    
    
    if([SFSafariViewController class]) {
        SFSafariViewController *safariController = [[SFSafariViewController alloc] initWithURL:nsurl];
        safariController.delegate = self;
        
        UINavigationController *safariNavigationController = [[UINavigationController alloc] initWithRootViewController:safariController];
        [safariNavigationController setNavigationBarHidden:YES animated:NO];
        
        [self presentViewController:safariNavigationController animated:YES completion:nil];
    } else {
        [[UIApplication sharedApplication] openURL:nsurl];
    }
    
    
}


-(IBAction)back_selector:(id)sender{
    self.navigationItem.leftBarButtonItem = nil;
    [self.webView removeFromSuperview];
}

@end
