//
//  StatisticsCell.h
//  Per La Gloria
//
//  Created by Seneta Yuriy on 10.08.16.
//  Copyright © 2016 Sergey Shatalov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Team.h"

@interface StatisticsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *equipoLabel;
@property (weak, nonatomic) IBOutlet UILabel *GCLabel;
@property (weak, nonatomic) IBOutlet UILabel *GFLabel;
@property (weak, nonatomic) IBOutlet UILabel *PPLabel;
@property (weak, nonatomic) IBOutlet UILabel *PELabel;
@property (weak, nonatomic) IBOutlet UILabel *PGLabel;
@property (weak, nonatomic) IBOutlet UILabel *PJLabel;
@property (weak, nonatomic) IBOutlet UILabel *ptsLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

- (void)updateWithTeam:(Team *)team withPosition:(NSUInteger)position;

@end
