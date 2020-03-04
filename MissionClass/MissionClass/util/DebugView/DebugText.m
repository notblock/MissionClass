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
}

- (id)initWithFrame:(CGRect)frame  {
    self = [super initWithFrame:frame];
    if (self) {
        debugStr = [[NSMutableAttributedString alloc] init];
        [self setEditable:NO];
    }
    return self;
}

- (void)clearText {
    debugStr = [[NSMutableAttributedString alloc] init];
    [self setAttributedText:debugStr];
}

- (NSString *)copyText {
    return debugStr.string;
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
