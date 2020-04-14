//
//  ClientViewController.m
//  MissionClass
//
//  Created by null on 2020/4/11.
//  Copyright © 2020 notblock. All rights reserved.
//

#import "ClientViewController.h"
#import "ClientManager.h"

@interface ClientViewController ()
@property (weak, nonatomic) IBOutlet UITextView *dailogText;
@property (weak, nonatomic) IBOutlet UITextField *inputText;
@property (weak, nonatomic) IBOutlet UIButton *Send;

@property (assign) int server_handle;
@property (nonatomic, strong) ClientManager *clientManager;
@end

@implementation ClientViewController

- (id)init {
    self = [super initWithNibName:@"ClientViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    __weak typeof(self) weakself = self;
    self.result = ^(id _Nonnull result) {
        [weakself setDailogs:result];
    };
}

- (void)setDailogs:(NSDictionary *)result {

    if ([result isKindOfClass:[NSDictionary class]]) {
        NSDictionary *data = (NSDictionary *)result;
        [self setDailog:data[@"m"]];
    }
}


- (void)setDailog:(NSString *)rev {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.dailogText setText:[self.dailogText.text stringByAppendingFormat:@"%@\n", rev]];        
    });
}

- (IBAction)ClientSend:(id)sender {
    if (self.inputText.text.length > 0) {
        NSDictionary *dic = @{@"f":self.sendIp,@"m":self.inputText.text};
        [[ClientManager shareInstance] sendMsg:0 Withmsg:dic];
    }
}

@end
