//
//  CustomTableViewCell.m
//  iOSTest
//
//  Created by Dnyaneshwar Balkrushna Wakchaure on 30/04/18.
//
//

#import "CustomTableViewCell.h"
#import <Masonry/Masonry.h>

@implementation CustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

// Programmatically Autolayout

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        
//        _imgView = [[UIImageView alloc] init];
//        _imgView.contentMode = UIViewContentModeScaleToFill;
//        [_imgView setTranslatesAutoresizingMaskIntoConstraints:NO];
//        
//        [self.contentView addSubview:_imgView];
//        
//        _titleLabel = [[UILabel alloc] init];
//        [_titleLabel setTextColor:[UIColor blackColor]];
//        [_titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:18.0f]];
//        [_titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
//        
//        [self.contentView addSubview:_titleLabel];
//        
//        _descLabel = [[UILabel alloc] init];
//        [_descLabel setTextColor:[UIColor blackColor]];
//        [_descLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:16.0f]];
//        [_descLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
//        [self.contentView addSubview:_descLabel];
//        
//        UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
//        
//        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.equalTo(@(100));
//            make.height.equalTo(@(100));
//            make.top.equalTo(self.contentView.mas_top).with.offset(padding.top);
//            make.left.equalTo(self.contentView.mas_left).with.offset(padding.left);
//            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-padding.bottom).priorityMedium();
//        }];
//        
//        UIEdgeInsets padding1 = UIEdgeInsetsMake(5, 10, 10, 10);
//        
//        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.contentView.mas_top).with.offset(padding1.top);
//            make.left.equalTo(_imgView.mas_right).with.offset(padding1.left);
//            make.right.equalTo(self.contentView.mas_right).with.offset(-padding1.right);
//        }];
//        
//        UIEdgeInsets padding2 = UIEdgeInsetsMake(5, 10, 10, 10);
//        
//        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_titleLabel.mas_bottom).with.offset(padding2.top);
//            make.left.equalTo(_imgView.mas_right).with.offset(padding2.left);
//            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-padding2.bottom);
//            
//            make.right.equalTo(self.contentView.mas_right).with.offset(-padding2.right);
//        }];
//        
//        
//    }
//    return self;
//}
@end
