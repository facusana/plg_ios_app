//
//  Player.h
//  Per La Gloria
//
//  Created by Sergey Shatalov on 14.08.16.
//  Copyright © 2016 Sergey Shatalov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (nonatomic, weak) NSString *playerName;
@property (nonatomic, weak) NSString *teamName;
@property (nonatomic, weak) NSNumber *goals;

- (instancetype)initWithDictionary:(NSDictionary *)dictInfo;

@end
