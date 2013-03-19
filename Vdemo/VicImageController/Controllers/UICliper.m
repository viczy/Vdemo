//
//  UICliper.m
//  image
//
//  Created by 岩 邢 on 12-7-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UICliper.h"

@implementation UICliper

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}
- (id)initWithImageView:(UIImageView*)iv
{
    CGRect r = [iv bounds];
    self = [super initWithFrame:r];
    if (self) {
        [iv addSubview:self];
        [iv setUserInteractionEnabled:YES];
        [self setBackgroundColor:[UIColor clearColor]];
        float size = r.size.height>r.size.width? r.size.width :r.size.height;
        cliprect = CGRectMake((r.size.width-size)/2, (r.size.height-size)/2, size, size);
        grayAlpha = [[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0.6] CGColor];
        [self setMultipleTouchEnabled:NO];
        touchPoint = CGPointZero;
        imgView = iv;
    }
    return self;
}

/**/
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    //绘制剪裁区域外半透明效果
    CGContextSetFillColorWithColor(context, grayAlpha);
    CGRect r = CGRectMake(0, 0, rect.size.width, cliprect.origin.y);
    CGContextFillRect(context, r);
    r = CGRectMake(0, cliprect.origin.y-0.2, cliprect.origin.x, cliprect.size.height);
    CGContextFillRect(context, r);
    r = CGRectMake(cliprect.origin.x + cliprect.size.width, cliprect.origin.y-0.2, rect.size.width - cliprect.origin.x - cliprect.size.width, cliprect.size.height);
    CGContextFillRect(context, r);
    r = CGRectMake(0, cliprect.origin.y + cliprect.size.height, rect.size.width, rect.size.height - cliprect.origin.y - cliprect.size.height+0.1);
    CGContextFillRect(context, r);
    //绘制剪裁区域的格子
    CGContextSetRGBStrokeColor(context, 1.0f, 1.0f, 1.0f, 0.8f);
    CGContextSetLineWidth(context, 2.0);
    CGContextAddRect(context, cliprect);
    CGContextMoveToPoint(context, cliprect.origin.x+cliprect.size.width/3, cliprect.origin.y);  
    CGContextAddLineToPoint(context, cliprect.origin.x+cliprect.size.width/3, cliprect.origin.y+cliprect.size.height);
    CGContextMoveToPoint(context, cliprect.origin.x+cliprect.size.width/3*2, cliprect.origin.y);  
    CGContextAddLineToPoint(context, cliprect.origin.x+cliprect.size.width/3*2, cliprect.origin.y+cliprect.size.height);
    
    CGContextMoveToPoint(context, cliprect.origin.x, cliprect.origin.y+cliprect.size.height/3);  
    CGContextAddLineToPoint(context, cliprect.origin.x+cliprect.size.width, cliprect.origin.y+cliprect.size.height/3);
    CGContextMoveToPoint(context, cliprect.origin.x, cliprect.origin.y+cliprect.size.height/3*2);  
    CGContextAddLineToPoint(context, cliprect.origin.x+cliprect.size.width, cliprect.origin.y+cliprect.size.height/3*2);
    CGContextStrokePath(context); 
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    touchPoint = [touch locationInView:self];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    float x1=.0f, x2=.0f, y1=.0f, y2=.0f;
    float x = touchPoint.x;
    float y = touchPoint.y;
    if (fabsf(x-cliprect.origin.x)<20) //左
    {
        float offy = y-cliprect.origin.y;
        if (fabsf(offy)<20) { //左上角
            x1 = p.x - touchPoint.x;
            y1 = p.y - touchPoint.y;
        }else if(fabsf(offy-cliprect.size.height)<20){ //左下角
            x1 = p.x - touchPoint.x;
            y2 = p.y - touchPoint.y;
        }else if(y>cliprect.origin.y && y<cliprect.origin.y+cliprect.size.height) { //左中部
            x1 = p.x - touchPoint.x;
        }
    }else if(fabsf(x-cliprect.origin.x-cliprect.size.width)<20) //右
    {
        float offy = y-cliprect.origin.y;
        if (fabsf(offy)<20) { //右上角
            x2 = p.x -touchPoint.x;
            y1 = p.y -touchPoint.y;
        }else if(fabsf(offy-cliprect.size.height)<20) { //右下角
            x2 = p.x - touchPoint.x;
            y2 = p.y - touchPoint.y;
        }else if(y>cliprect.origin.y && y<cliprect.origin.y+cliprect.size.height) { //右中部
            x2 = p.x - touchPoint.x;
        }
    }else if(fabsf(y-cliprect.origin.y)<20){ //上
        if (x>cliprect.origin.x && x< cliprect.size.width) { //上中
            y1 = p.y - touchPoint.y;
        }
    }else if(fabsf(y-cliprect.origin.y-cliprect.size.height)<20){ //下
        if (x>cliprect.origin.x && x< cliprect.size.width) { //下中
            y2 = p.y - touchPoint.y;
        }
    }else if((x>cliprect.origin.x && x< cliprect.origin.x+cliprect.size.width)&&(y>cliprect.origin.y && y<cliprect.origin.y+cliprect.size.height)){ //正中
        cliprect.origin.x += (p.x -touchPoint.x);
        cliprect.origin.y += (p.y -touchPoint.y);
        if (cliprect.origin.x<0) {
            cliprect.origin.x=0;
        }else if(cliprect.origin.x>self.bounds.size.width-cliprect.size.width)
        {
            cliprect.origin.x=self.bounds.size.width-cliprect.size.width;
        }
        if (cliprect.origin.y<0) {
            cliprect.origin.y=0;
        }else if(cliprect.origin.y>self.bounds.size.height-cliprect.size.height)
        {
            cliprect.origin.y=self.bounds.size.height-cliprect.size.height;
        }
    }else {
        return;
    }
    //修改rect
    [self ChangeclipEDGE:x1 x2:x2 y1:y1 y2:y2];
    [self setNeedsDisplay];
    touchPoint = p;
}

//休整剪切区域
- (void)ChangeclipEDGE:(float)x1 x2:(float)x2 y1:(float)y1 y2:(float)y2
{
    cliprect.origin.x += x1;
    cliprect.size.width -= x1;
    cliprect.origin.y += y1;
    cliprect.size.height -= y1;
    cliprect.size.width += x2;
    cliprect.size.height += y2;
    if (cliprect.size.width<60) {
        if (x1>0.f) {
            cliprect.origin.x -= 60.0 - cliprect.size.width;
        }
        cliprect.size.width = 60;
    }else if(cliprect.size.height<60) {
        if (y1>0.f) {
            cliprect.origin.y -= 60.0 - cliprect.size.height;
        }
        cliprect.size.height = 60;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    touchPoint = CGPointZero;
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

- (void)setclipEDGE:(CGRect)rect
{
    cliprect = rect;
    [self setNeedsDisplay];
}

- (void)dealloc
{
    [super dealloc];
}

- (CGRect)getclipRect
{
    [self ChangeclipEDGE:0 x2:0 y1:0 y2:0];
    [self setNeedsDisplay];
    float imgsize = [imgView image].size.width;
    float viewsize = [imgView frame].size.width;
    float scale = imgsize/viewsize;
    CGRect r = CGRectMake(cliprect.origin.x*scale, cliprect.origin.y*scale, cliprect.size.width*scale, cliprect.size.height*scale);
    return r;
}

-(void)setClipRect:(CGRect)rect
{
    cliprect = rect;
    [self setNeedsDisplay];
}

-(UIImage*)getClipImageRect:(CGRect)rect
{
    CGImageRef imgrefout = CGImageCreateWithImageInRect([imgView.image CGImage], rect);
    UIImage *img_ret = [[UIImage alloc]initWithCGImage:imgrefout];
    return [img_ret autorelease];
}


@end
