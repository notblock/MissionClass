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
@property (weak, nonatomic) IBOutlet UIButton *Connect;

@property (assign) int server_handle;
@property (nonatomic, strong) ClientManager *clientManager;
@end

@implementation ClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.clientManager = [[ClientManager alloc] init];
    
}

- (void)setServHandle:(int)handle setRev:(NSString *)rev {
    self.server_handle = handle;
    [self setDailog:rev];
}


- (void)setDailog:(NSString *)rev {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.dailogText setText:[self.dailogText.text stringByAppendingFormat:@"%@\n", rev]];        
    });
}

- (IBAction)ClientConnect:(id)sender {
    __weak typeof(self) wksf = self;
    [self.clientManager client:^(int server_handle, NSString * _Nonnull revStr)
    {
        [wksf setServHandle:server_handle setRev:revStr];
    }];
}
static int sendNum = 0;
- (IBAction)ClientSend:(id)sender {
    if (self.inputText.text.length > 0) {
        [self.clientManager sendMsg:self.server_handle Withmsg:[NSString stringWithFormat:@"%@%d\n",self.inputText.text, sendNum ++]];
    }
}

- (IBAction)stop:(id)sender {
    [self.clientManager stop:self.server_handle];
}
@end
