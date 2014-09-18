//
//  Detail.h
//  EveryTasks
//
//  Created by OkadaHiroaki on 2014/09/17.
//  Copyright (c) 2014年 HiroakiOkada. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Title;

@interface Detail : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) Title *title;

@end
