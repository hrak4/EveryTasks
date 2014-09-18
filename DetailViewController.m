//
//  DetailViewController.m
//  EveryTasks
//
//  Created by OkadaHiroaki on 2014/09/09.
//  Copyright (c) 2014年 HiroakiOkada. All rights reserved.
//

#import "DetailViewController.h"
#import "MasterViewController.h"
#import "Detail.h"
@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

@synthesize detailItem = _detailItem;

#pragma mark - Managing the detail item


- (Title *) detailItem
{
    //空の箱を新規作成。　修正ではない  データ構造を明確に定義
    if(!_detailItem){
        _detailItem = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Title class]) inManagedObjectContext:self.managedObjectContext];
        _detailItem.detail = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Detail class]) inManagedObjectContext:self.managedObjectContext];
    }
    
    return _detailItem;
}



- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }

}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        
        self.summaryField.text = self.detailItem.summary;
        self.descTextView.text = self.detailItem.detail.desc;
        //作成したときの時間を追加
        //self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"date"] description];
    }
}


- (void)done
{
    self.detailItem.summary =self.summaryField.text;
    self.detailItem.detail.desc = self.descTextView.text;
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@",error,[error userInfo]);
        abort();
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        //Push segueで前の画面へ戻る構文
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewDidLoad
{
        [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                           target:self action:@selector(done)];
    [self configureView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action: @selector(view_Tapped:)];
    [self.view addGestureRecognizer:tapGesture];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//TextViewのキーボードを下げる
- (void)view_Tapped:(UITapGestureRecognizer *)sender
{
    [_descTextView resignFirstResponder];
 NSLog(@"タップされました．");
}

- (IBAction)fieldReturn:(id)sender {
}
@end
