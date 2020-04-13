//
//  ClientManager.m
//  MissionClass
//
//  Created by null on 2020/4/11.
//  Copyright © 2020 notblock. All rights reserved.
//

#import "ClientManager.h"
#include <netinet/in.h>
#include <sys/socket.h>
#include <arpa/inet.h>

@implementation ClientManager
{
    dispatch_queue_t client_queue;
}
- (id)init {
    self = [super init];
    if (self) {
        client_queue = dispatch_queue_create("com.notblock.client_queue", NULL);
    }
    return self;
}

- (void)client:(void(^)(int server_handle, NSString *revStr))block {
    struct sockaddr_in server_addr;
    server_addr.sin_len = sizeof(struct sockaddr_in);
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(12306);
    server_addr.sin_addr.s_addr = inet_addr("10.17.141.11");
    bzero(&(server_addr.sin_zero),8);
    
    int server_socket = socket(AF_INET, SOCK_STREAM, 0);
    if (server_socket == -1) {
        perror("socket error");
//        return 1;
    }
    printf("client will connect \n");
        if (connect(server_socket, (struct sockaddr *)&server_addr, sizeof(struct sockaddr_in))==0)     {
            dispatch_async(client_queue, ^{
                char recv_msg[1024];
                char reply_msg[1024];
            //connect 成功之后，其实系统将你创建的socket绑定到一个系统分配的端口上，且其为全相关，包含服务器端的信息，可以用来和服务器端进行通信。
                long byte_num = 0 ;
                do {
                    bzero(recv_msg, 1024);
                    bzero(reply_msg, 1024);
                    byte_num = recv(server_socket,recv_msg,1024,0);
                    recv_msg[byte_num] = '\0';
                    NSString *rev = [NSString stringWithUTF8String:recv_msg];
                    block(server_socket, rev);
                    
                } while (byte_num > 0);
                
                close(server_socket);
            });
        } else {
            perror("connect error");
        }
}


- (void)sendMsg:(int)server_handle Withmsg:(NSString *)msg {
    if(send(server_handle, msg.UTF8String, strlen(msg.UTF8String), 0)==-1) {
        perror("send error");
    }
}

- (void)stop:(int)server_handle {
    close(server_handle);
}

@end
