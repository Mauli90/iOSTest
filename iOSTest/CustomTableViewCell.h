//
//  CustomTableViewCell.h
//  iOSTest
//
//  Created by Dnyaneshwar Balkrushna Wakchaure on 30/04/18.
//
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
//@property (nonatomic, strong) UIImageView * imgView;
//@property (nonatomic, strong) UILabel * titleLabel;
//@property (nonatomic, strong) UILabel * descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@end
