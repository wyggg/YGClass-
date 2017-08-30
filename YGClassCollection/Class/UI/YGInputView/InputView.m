//
//  InputView.m
//  MeiDaDaForipad
//
//  Created by iOS 开发 on 16/6/6.
//  Copyright © 2016年 zhangping. All rights reserved.
//

#import "InputView.h"
#import "NSString+YGTool.h"
#import <Masonry.h>
@implementation InputView

- (id)init{
    if (self = [super init]) {
        self.lengthLimit = 500;
        [self loadUI];
    }
    return self;
}

- (void)loadUI{
    
    self.promptLabel = [[UILabel alloc] init];
    self.promptLabel.textColor = [UIColor darkTextColor];
    self.promptLabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:self.promptLabel];
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(5);
        make.left.offset(10);
        make.right.offset(0);
        make.height.offset(20);
    }];
    
    self.textView = [[UITextView alloc] init];
    self.textView.delegate = self;
    self.textView.font = [UIFont systemFontOfSize:14];
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.textColor = [UIColor blackColor];
    [self addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(0);
    }];
    
    self.meslabel = [[UILabel alloc] init];
    self.meslabel.hidden = YES;
    self.meslabel.font = [UIFont systemFontOfSize:12];
    self.meslabel.textAlignment = NSTextAlignmentRight;
    self.meslabel.textColor = [UIColor darkTextColor];
    [self addSubview:self.meslabel];
    [self.meslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-5);
        make.bottom.offset(-5);
        make.height.offset(10);
    }];
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    ///新方法不顶用 所以还是用老方法
    if ([[[UITextInputMode currentInputMode] primaryLanguage] isEqualToString:@"emoji"]) {
        return NO;
    }
//    if ([text isContainsEmoji]) {
//        return NO;
//    }
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView{
   
    
   self.promptLabel.alpha = textView.text.length==0?1:0;
     self.meslabel.text = [NSString stringWithFormat:@"%lu/%ld",(unsigned long)textView.text.length,(long)self.lengthLimit];
    //移除表情

    
    NSString *toBeString = textView.text;
    
    //获取高亮部分
    UITextRange *selectedRange = [textView markedTextRange];
    UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
    
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position)
    {
        if (toBeString.length > self.lengthLimit)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.lengthLimit];
            if (rangeIndex.length == 1)
            {
                textView.text = [toBeString substringToIndex:self.lengthLimit];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.lengthLimit)];
                textView.text = [toBeString substringWithRange:rangeRange];
            }
            NSLog(@"超出限制");
        }
    }
    
    if ([textView.text isContainsEmoji]) {
        textView.text = textView.text.removeAllEmiji;
    }
   
    if (self.textViewDidChange) {
        self.textViewDidChange(textView.text);
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if (self.textViewDidEndEditing) {
        self.textViewDidEndEditing(textView.text);
        [textView setContentOffset:CGPointMake(0.f,0)];
    }
}
@end
