*这是斜体*   
**粗体**  
[这是一个超级连接](www.sina.com.cn)  



strong weak retain assign的区别
=============
&ensp;&ensp;strong与weak是由ARC新引入的对象变量属性 xcode 4.2（ios sdk4.3和以下版本）和之前的版本使用的是retain和assign，是不支持ARC的。xcode 4.3（ios5和以上版本）之后就有了ARC，并且开始使用 strong与weak.  
assign:用于非指针变量
-------------
assign用于非指针变量.用于基础数据类型(例如NSInteger)和C数据类型(int float double char等),另外还有id如:  
@property(nonatomic,assign) int number;  
@property(nonatomic,assign) id className;//id必须用assign  
反正记住:前面不需要加*的就用assign吧

retain:用于指针变量
------------------
retain用于指针变量.就是说你定义了一个变量,然后这个变量在程序的运行过程中会被更改,并且影响到其他方法,一般用于字符串(NSString NSMutableString) 数组(NSMutableArray NSArray)字典对象(NSDictionary) 视图对象(UIView) 控制器对象(UIViewController)等  
比如:  
@property(nonatomic,retain) NSString *myString;
@property(nonatomic,retain) UIView *myView;
@property(nonatomic,retain) UIViewController *myViewController;  
如果你在xcode4.3上面开发,retain与strong都是一样的,没有区别

strong和weak
-------------------
@property(nonatomic,strong) MyClass *myObject就是相当于下面的  
@property(nonatomic,retain) MyClass *myObject  

@property(nonatomic,weak)id <RNNewsFeedCellDelegate>delegate;就是相当于下面的  
@@property(nonatomic,assign)id <RNNewsFeedCellDelegate>delegate;
weak就是相当于assign,所以建议大家用assign来替代
###这是一个三级标题
