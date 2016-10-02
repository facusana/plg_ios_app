//
//  Customer.h
//  Per La Glory
//
//  Created by Sergey Shatalov on 08.08.16.
//  Copyright © 2016 Sergey Shatalov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Customer : NSObject

@property (nonatomic) NSNumber *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic) BOOL isActive;
@property (nonatomic) BOOL isSelected;

- (instancetype)initWithDictionary:(NSDictionary *)dictInfo;

@end
