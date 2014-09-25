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


// 今回ここではdetailItemを生成したり、追加処理をすることを必要とせず、MasterViewから引き継いだdetailItemを使うだけなので
// ここにdetailItemのゲッターメソッドは必要ないかと思われる(西出 2014/09/23)
//- (Title *) detailItem
//{
//    //空の箱を新規作成。　修正ではない  データ構造を明確に定義
//    if(!_detailItem){
//        _detailItem = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Title class]) inManagedObjectContext:self.managedObjectContext];
//        _detailItem.detail = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Detail class]) inManagedObjectContext:self.managedObjectContext];
//    }
//    return _detailItem;
//}


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

//textFieldの編集が始まったときに処理が実行されるメソッド
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    NSLog(@"hogehoge");
//
//    return YES;
//}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //textFieldのパラメータを使って現在入力されている文字列を取得
    NSString *summaryText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([summaryText length] > 0) {
        //文字列が１文字以上だった場合はdoneボタンを使用可能
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
    } else {
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
    }
    
    return YES;
}


- (void)done
{
    //空の箱を新規作成。　修正ではない  データ構造を明確に定義
    if(!_detailItem){
        _detailItem = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Title class]) inManagedObjectContext:self.managedObjectContext];
        _detailItem.detail = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Detail class]) inManagedObjectContext:self.managedObjectContext];
    }
    
    self.detailItem.summary =self.summaryField.text;
    self.detailItem.detail.desc = self.descTextView.text;

    
//    NSString *text = self.summaryField.text;
//    NSInteger stringLength = [text length];
//    NSInteger stringCount = [self.summaryField.text length]; // 上二行と同じ事を書いてるけど、ワンライナーなんでコメントアウト
    
    

    
    
    //現在日付取得
    NSDate *now = [[NSDate date]init];
    //coreDateに保存
    [self.detailItem setValue:now forKey:@"date"];
//    self.detailItem.date = now;
    
    
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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    [self configureView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action: @selector(view_Tapped:)];
    [self.view addGestureRecognizer:tapGesture];

    // テキストフィールドのデリゲータをセット
//    [self.summaryField setDelegate:self];
    self.summaryField.delegate = self;

    // サマリーフィールドにデータが未入力の場合はdoneボタンが効かないように設定
    NSString *summaryText = self.summaryField.text;
    if ([summaryText length] == 0) {
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
    }
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
