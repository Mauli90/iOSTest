//
//  CustomTableViewCell.m
//  iOSTest
//
//  Created by Dnyaneshwar Balkrushna Wakchaure on 30/04/18.
//
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        int width = [[UIScreen mainScreen] bounds].size.width;
        
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [_imgView setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [self.contentView addSubview:_imgView];
        
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextColor:[UIColor blackColor]];
        [_titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:18.0f]];
        [_titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [self.contentView addSubview:_titleLabel];
        
        _descLabel = [[UILabel alloc] init];
        [_descLabel setTextColor:[UIColor blackColor]];
        [_descLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:18.0f]];
        [_descLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:_descLabel];
        
    }
    return self;
}
@end
