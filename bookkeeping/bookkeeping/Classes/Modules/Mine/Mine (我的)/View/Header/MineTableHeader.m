/**
 * 我的头视图
 * @author 郑业强 2018-12-16 创建文件
 */

#import "MineTableHeader.h"
#import "MINE_EVENT_MANAGER.h"

#pragma mark - 声明
@interface MineTableHeader()

@property (weak, nonatomic) IBOutlet UIButton *punchBtn;    // 打卡
@property (weak, nonatomic) IBOutlet UIImageView *icon;     // 头像
@property (weak, nonatomic) IBOutlet UILabel *nameLab;      // 姓名
@property (weak, nonatomic) IBOutlet UIView *infoView;      // 个人信息
@property (weak, nonatomic) IBOutlet UIView *punchView;
@property (weak, nonatomic) IBOutlet UIView *dayView;
@property (weak, nonatomic) IBOutlet UIView *numberView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconConstraintW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *punchConstraintW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoConstraintT;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *numberConstraintT;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *punchConstraintT;

@end


#pragma mark - 实现
@implementation MineTableHeader


- (void)initUI {
    [self setBackgroundColor:kColor_Main_Color];
    [self createLabel:self];
    [self.infoView setBackgroundColor:[UIColor clearColor]];
    [self.nameLab setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
    [self.nameLab setTextColor:kColor_Text_Black];
    [self.punchBtn.layer setCornerRadius:self.punchBtn.height / 2];
    [self.punchBtn.layer setMasksToBounds:YES];
    [self.punchBtn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(10)]];
    [self.punchBtn setTitleColor:kColor_Text_Black forState:UIControlStateNormal];
    [self.punchBtn setTitleColor:kColor_Text_Black forState:UIControlStateHighlighted];
    [self.icon.layer setCornerRadius:countcoordinatesX(60) / 2];
    [self.icon.layer setMasksToBounds:true];
    
    [self.iconConstraintW setConstant:countcoordinatesX(60)];
    [self.punchConstraintW setConstant:countcoordinatesX(70)];
    [self.numberConstraintT setConstant:countcoordinatesX(10)];
    [self.infoConstraintT setConstant:StatusBarHeight + countcoordinatesX(40)];
    [self.punchConstraintT setConstant:StatusBarHeight + countcoordinatesX(5)];
    
    
    @weakify(self)
    // 头像
    [self.infoView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        @strongify(self)
        [self routerEventWithName:MINE_HEADER_ICON_CLICK data:nil];
    }];
    // 连续打卡
    [self.punchView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        @strongify(self)
        [self routerEventWithName:MINE_HEADER_PUNCH_CLICK data:nil];
    }];
    // 记账总天数
    [self.dayView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        @strongify(self)
        [self routerEventWithName:MINE_HEADER_DAY_CLICK data:nil];
    }];
    // 记账总笔数
    [self.numberView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        @strongify(self)
        [self routerEventWithName:MINE_HEADER_NUMBER_CLICK data:nil];
    }];
    
}
- (void)createLabel:(UIView *)view {
    for (UIView *subview in view.subviews) {
        [self createLabel:subview];
        if ([subview isKindOfClass:[UILabel class]]) {
            if (subview.tag == 10) {
                UILabel *lab = (UILabel *)subview;
                lab.font = [UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight];
                lab.textColor = kColor_Text_Black;
            }
            else if (subview.tag == 11) {
                UILabel *lab = (UILabel *)subview;
                lab.font = [UIFont systemFontOfSize:AdjustFont(10) weight:UIFontWeightLight];
                lab.textColor = kColor_Text_Black;
            }
        }
    }
}


#pragma mark - set
- (void)setModel:(UserModel *)model {
    _model = model;
    // 未登录
    if (!model) {
        [_icon setImage:[UIImage imageNamed:@"default_header"]];
        [_nameLab setText:@"未登录"];
        return;
    }
    // 登录
    if (model.icon) {
        [_icon sd_setImageWithURL:[NSURL URLWithString:KStatic(model.icon)]];
    } else {
        [_icon setImage:[UIImage imageNamed:@"default_header"]];
    }
    [_nameLab setText:model.nickname];
}


#pragma mark - 点击
// 打卡
- (IBAction)punchClick:(UIButton *)sender {
    [sender setTitle:@"已打卡" forState:UIControlStateNormal];
    [sender setTitle:@"已打卡" forState:UIControlStateHighlighted];
    
    [sender setImage:nil forState:UIControlStateNormal];
    [sender setImage:nil forState:UIControlStateHighlighted];
    
    [self routerEventWithName:MINE_PUNCH_CLICK data:nil];
}


@end
