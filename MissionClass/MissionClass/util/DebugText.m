//
//  DebugText.m
//  MissionClass
//
//  Created by notblock on 2020/3/2.
//  Copyright © 2020 notblock. All rights reserved.
//

#import "DebugText.h"

@implementation DebugText
{
    NSMutableAttributedString *debugStr;
    UILabel *_titleLab;
    UIButton *_clearBtn;
}

- (id)initWithFrame:(CGRect)frame  {
    self = [super initWithFrame:frame];
    if (self) {
        debugStr = [[NSMutableAttributedString alloc] init];
        [self setEditable:NO];
        [self setContentInset:UIEdgeInsetsMake(CGRectGetHeight(self.titleLab.frame) + 2, 0, CGRectGetHeight(self.clearBtn.frame) + 2, 0)];
    }
    return self;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, CGRectGetWidth([UIScreen mainScreen].bounds) - 40, 20)];
        [titleLab setTextColor:[UIColor blackColor]];
        [titleLab setText:@"debug text"];
        [titleLab setFont:[UIFont systemFontOfSize:17]];
        _titleLab = titleLab;
        [self addSubview:titleLab];
    }
    return _titleLab;
}


- (UIButton *)clearBtn {
    if (!_clearBtn) {
        UIButton *titleLab = [[UIButton alloc] initWithFrame:CGRectMake(120, 0, CGRectGetWidth([UIScreen mainScreen].bounds) - 120, 20)];
        [titleLab setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titleLab setTitle:@"clear btn" forState:UIControlStateNormal];
        [titleLab.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [titleLab addTarget:self action:@selector(clearText) forControlEvents:UIControlEventTouchUpInside];
        _clearBtn = titleLab;
        [self addSubview:titleLab];
    }
    return _clearBtn;
}

- (void)clearText {
    debugStr = [[NSMutableAttributedString alloc] init];
    [self setAttributedText:debugStr];
}


- (void)logInfo:(NSString *)logstr {
    
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:logstr attributes:@{NSAttachmentAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor blackColor]}];
    [debugStr appendAttributedString:str];
    [self setAttributedText:debugStr];
}

- (void)logError:(NSString *)logstr {
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:logstr attributes:@{NSAttachmentAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor redColor]}];
    [debugStr appendAttributedString:str];
    [self setAttributedText:debugStr];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
