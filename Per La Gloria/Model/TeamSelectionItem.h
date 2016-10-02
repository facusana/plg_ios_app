//
//  TeamSelectionItem.h
//  Per La Gloria
//
//  Created by Sergey Shatalov on 10.08.16.
//  Copyright © 2016 Sergey Shatalov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeamSelectionItem : NSObject
@property (nonatomic) NSNumber *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) BOOL isSelected;
@end
