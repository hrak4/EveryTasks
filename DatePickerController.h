//
//  DatePickerController.h
//  EveryTasks
//
//  Created by OkadaHiroaki on 2014/09/12.
//  Copyright (c) 2014年 HiroakiOkada. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DatePickerController;

@interface DatePickerController : UIViewController
{
IBOutlet UIButton *commitButton;
IBOutlet UIButton *cancelButton;
}

- (IBAction)commitButtonClicked:(id)sender;
- (IBAction)cancelButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) NSString *nowDate;


@end
