//
//  CustomTableViewCell.h
//  EveryTasks
//
//  Created by OkadaHiroaki on 2014/09/16.
//  Copyright (c) 2014年 HiroakiOkada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *checkImg;
@property (weak, nonatomic) IBOutlet UILabel *titleCell;
@property (weak, nonatomic) IBOutlet UILabel *dateCell;

@end
