//
//  DebugView.m
//  MissionClass
//
//  Created by null on 2020/3/3.
//  Copyright © 2020 notblock. All rights reserved.
//

#import "DebugView.h"
#import "DebugText.h"

@implementation DebugView
{
    DebugText *_debugText;
    UILabel *titleStr;
    UIButton *clearBtn;
    UIButton *copyBtn;
}
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        titleStr = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, 120, 24)];
        [titleStr setFont:[UIFont systemFontOfSize:15]];
        [titleStr setTextColor:[UIColor blackColor]];
        [titleStr setText:@"log print:"];
        [self addSubview:titleStr];
        
        clearBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 88, 3, 88, 24)];
        [clearBtn setTitle:@"clear" forState:UIControlStateNormal];
        [clearBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [clearBtn addTarget:self action:@selector(clearDebugText) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:clearBtn];
        
        copyBtn = [[UIButton alloc] initWithFrame:CGRectMake( CGRectGetMinX(clearBtn.frame) - 88, 3, 88, 24)];
        [copyBtn setTitle:@"copy" forState:UIControlStateNormal];
        [copyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [copyBtn addTarget:self action:@selector(copyPaser) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:copyBtn];
        
        [self.debugText setFrame:CGRectMake(15, CGRectGetMaxY(copyBtn.frame) + 3, CGRectGetWidth([UIScreen mainScreen].bounds) - 30,  CGRectGetHeight(self.frame) - 63)];
        
    }
    return self;
}


- (DebugText *)debugText {
    if (!_debugText) {
        DebugText *debugText = [[DebugText alloc] init];
        [self addSubview:debugText];
        _debugText = debugText;
    }
    return _debugText;
}

- (void)clearDebugText {
    [self.debugText clearText];
}


- (void)copyPaser {
    UIPasteboard *paste = [UIPasteboard pasteboardWithUniqueName];
    paste.string = [self.debugText copyText];
}

- (void)logInfo:(NSString *)logstr {
    [self.debugText logInfo:logstr];
    [self.debugText scrollRangeToVisible:NSMakeRange(self.debugText.attributedText.string.length, 1)];
}

- (void)logError:(NSString *)logstr {
    [self.debugText logError:logstr];
    [self.debugText scrollRangeToVisible:NSMakeRange(self.debugText.attributedText.string.length, 1)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
