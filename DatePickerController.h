//
//  DatePickerController.h
//  EveryTasks
//
//  Created by OkadaHiroaki on 2014/09/12.
//  Copyright (c) 2014年 HiroakiOkada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Title.h"

@class DatePickerController;

@interface DatePickerController : UIViewController
<NSFetchedResultsControllerDelegate>
{
    NSArray *List;
    IBOutlet UIButton *commitButton;
    IBOutlet UIButton *cancelButton;
}
@property (strong, nonatomic) Title *detailItem;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
- (IBAction)commitButtonClicked:(id)sender;
- (IBAction)cancelButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) NSString *nowDate;
@property (nonatomic) NSInteger selectnum;

@end
