//
//  TeamSelectionTableViewCell.h
//  Per La Gloria
//
//  Created by Sergey Shatalov on 09.08.16.
//  Copyright © 2016 Sergey Shatalov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamSelectionTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIStackView *imageAndLabelStackView;
@property (strong, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
