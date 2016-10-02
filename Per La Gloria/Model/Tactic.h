//
//  Tactic.h
//  Per La Glory
//
//  Created by Sergey Shatalov on 08.08.16.
//  Copyright © 2016 Sergey Shatalov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tactic : NSObject

@property (nonatomic) NSNumber *id;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *tacticDescription;

- (instancetype)initWithDictionary:(NSDictionary *)dictInfo;

@end
