//
//  DetailViewController.h
//  EveryTasks
//
//  Created by OkadaHiroaki on 2014/09/09.
//  Copyright (c) 2014年 HiroakiOkada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Title.h"
@interface DetailViewController : UIViewController

@property (strong, nonatomic) Title *detailItem;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UITextField *summaryField;
@property (weak, nonatomic) IBOutlet UITextView *descTextView;
- (IBAction)fieldReturn:(id)sender;

@end
